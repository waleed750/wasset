import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

/// Compresses [input] image file until it's <= 2MB (2 * 1024 * 1024 bytes).
///
/// - If input size is already <= 2MB, returns the original file.
/// - Otherwise tries progressive quality reductions then resizing widths.
/// - Output is JPEG stored in temporary directory. Preserves EXIF when possible.
/// Compresses [input] image file until it's <= 2MB (2 * 1024 * 1024 bytes).
///
/// - Cleans up old temp compressed files before starting.
/// - If input size is already <= 2MB, returns the original file.
/// - Otherwise tries progressive quality reductions then resizing widths.
/// - Output is JPEG stored in temporary directory. Preserves EXIF when possible.
Future<File> compressToUnder2MB(File input) async {
  const maxBytes = 2 * 1024 * 1024;

  final originalSize = await input.length();
  if (originalSize <= maxBytes) return input;

  final tempDir = await getTemporaryDirectory();
  final baseName = p.basenameWithoutExtension(input.path);

  // Clean up old temp compressed files for this image
  try {
    final entries = tempDir.listSync();
    for (final e in entries) {
      if (e is File) {
        final name = p.basename(e.path);
        if (name.startsWith('${baseName}_cmp_') && name.endsWith('.jpg')) {
          e.deleteSync();
        }
      }
    }
  } catch (_) {
    // ignore errors
  }

  // quality-first attempts
  final qualitySteps = <int>[95, 85, 75, 65, 55, 45, 35, 25];
  final widthSteps = <int>[1920, 1600, 1280, 1024, 800, 640, 480];

  Future<File?> tryCompress({int minWidth = 1920, required int quality}) async {
    try {
      final result = await FlutterImageCompress.compressWithFile(
        input.path,
        minWidth: minWidth,
        quality: quality,
        keepExif: true,
      );
      if (result == null || result.isEmpty) return null;
      final outPath = p.join(
        tempDir.path,
        '${baseName}_cmp_${minWidth ?? 0}_q$quality${DateTime.now().millisecondsSinceEpoch}.jpg',
      );
      final outFile = File(outPath);
      await outFile.writeAsBytes(result, flush: true);
      return outFile;
    } catch (_) {
      return null;
    }
  }

  // first try reducing quality only
  for (final q in qualitySteps) {
    final out = await tryCompress( quality: q);
    if (out == null) continue;
    final len = await out.length();
    if (len <= maxBytes) return out;
  }

  // then try resizing with decreasing widths + quality steps
  for (final w in widthSteps) {
    for (final q in qualitySteps) {
      final out = await tryCompress(minWidth: w, quality: q);
      if (out == null) continue;
      final len = await out.length();
      if (len <= maxBytes) return out;
    }
  }

  // if all attempts fail, return the smallest produced file (if any), otherwise original
  // Keep track of produced candidates and return the smallest one if none met the limit
  final candidates = <File>[];

  // collect files produced by previous attempts in temp dir
  try {
    final entries = tempDir.listSync();
    for (final e in entries) {
      if (e is File) {
        final name = p.basename(e.path);
        if (name.startsWith('${baseName}_cmp_') && name.endsWith('.jpg')) {
          candidates.add(e);
        }
      }
    }
  } catch (_) {
    // ignore listing errors
  }

  if (candidates.isNotEmpty) {
    candidates.sort((a, b) => a.lengthSync().compareTo(b.lengthSync()));
    final best = candidates.first;
    final bestLen = await best.length();
    if (bestLen <= maxBytes) return best;
    return best; // return smallest even if >2MB (caller will skip)
  }

  // fallback: try a final aggressive compression
  final finalOut = await tryCompress(minWidth: 480, quality: 20);
  if (finalOut != null) {
    final len = await finalOut.length();
    if (len <= maxBytes) return finalOut;
    return finalOut; // even if >2MB, caller will check and skip
  }

  return input;
}
