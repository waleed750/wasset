import 'dart:io';

import 'package:exif/exif.dart' as exif;
import 'package:image/image.dart' as img;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Compresses [input] image file until it's <= 2MB (2 * 1024 * 1024 bytes).
///
/// - Pure-Dart implementation (no native plugins) using `image` and `exif`.
/// - If input size is already <= 2MB, returns the original file.
/// - Otherwise tries progressive quality reductions then resizing widths.
/// - Output is JPEG stored in temporary directory. Tries to preserve EXIF orientation.
Future<File> compressToUnder2MB(File input) async {
  const maxBytes = 2 * 1024 * 1024;

  final originalSize = await input.length();
  if (originalSize <= maxBytes) return input;

  final tempDir = await getTemporaryDirectory();
  final baseName = p.basenameWithoutExtension(input.path);

  // try to remove old temp outputs for this baseName
  try {
    for (final e in tempDir.listSync()) {
      if (e is File) {
        final name = p.basename(e.path);
        if (name.startsWith('${baseName}_cmp_') && name.endsWith('.jpg')) {
          try {
            e.deleteSync();
          } catch (_) {}
        }
      }
    }
  } catch (_) {}

  final qualitySteps = <int>[95, 85, 75, 65, 55, 45, 35, 25];
  final widthSteps = <int>[1920, 1600, 1280, 1024, 800, 640, 480];

  final bytes = await input.readAsBytes();

  // Read EXIF orientation
  var orientation = 1;
  try {
    final tags = await exif.readExifFromBytes(bytes);
    final orientTag = tags?['Image Orientation'] ?? tags?['Orientation'];
    if (orientTag != null) {
      final printable = orientTag.printable ?? '';
      final match = RegExp(r'\d+').firstMatch(printable);
      if (match != null) orientation = int.tryParse(match.group(0) ?? '1') ?? 1;
    }
  } catch (_) {
    // ignore exif errors
  }

  final decoded = img.decodeImage(bytes);
  if (decoded == null) return input;

  // apply orientation correction
  var oriented = decoded;
  switch (orientation) {
    case 3:
      oriented = img.copyRotate(decoded, angle: 180);
      break;
    case 6:
      oriented = img.copyRotate(decoded, angle: 90);
      break;
    case 8:
      oriented = img.copyRotate(decoded, angle: -90);
      break;
    default:
      oriented = decoded;
  }

  Future<File> writeJpeg(img.Image image, int quality, int tagWidth) async {
    final data = img.encodeJpg(image, quality: quality);
    final outPath = p.join(
      tempDir.path,
      '${baseName}_cmp_${tagWidth}_q${quality}_${DateTime.now().millisecondsSinceEpoch}.jpg',
    );
    final out = File(outPath);
    await out.writeAsBytes(data, flush: true);
    return out;
  }

  // try quality reductions first
  for (final q in qualitySteps) {
    final out = await writeJpeg(oriented, q, 0);
    final len = await out.length();
    if (len <= maxBytes) return out;
  }

  // then try resizing + quality
  for (final w in widthSteps) {
    final resized = img.copyResize(oriented, width: w);
    for (final q in qualitySteps) {
      final out = await writeJpeg(resized, q, w);
      final len = await out.length();
      if (len <= maxBytes) return out;
    }
  }

  // pick smallest candidate if any
  final candidates = <File>[];
  try {
    for (final e in tempDir.listSync()) {
      if (e is File) {
        final name = p.basename(e.path);
        if (name.startsWith('${baseName}_cmp_') && name.endsWith('.jpg')) {
          candidates.add(e);
        }
      }
    }
  } catch (_) {}

  if (candidates.isNotEmpty) {
    candidates.sort((a, b) => a.lengthSync().compareTo(b.lengthSync()));
    return candidates.first;
  }

  // fallback: return original (caller may skip if >2MB)
  return input;
}
