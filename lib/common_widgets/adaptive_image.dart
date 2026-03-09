import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider adaptiveImageProvider(String? path) {
  if (path == null || path.isEmpty) return const AssetImage('');

  final p = path.trim();
  try {
    if (p.startsWith('http')) return NetworkImage(p);
    if (p.startsWith('file://')) return FileImage(File(Uri.parse(p).toFilePath()));
    return FileImage(File(p));
  } catch (_) {
    return const AssetImage('');
  }
}

class AdaptiveImage extends StatelessWidget {
  const AdaptiveImage({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.fit,
    this.errorWidget,
  });

  final String? path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    if (path == null || path!.isEmpty) {
      return errorWidget ?? const SizedBox.shrink();
    }

    final provider = adaptiveImageProvider(path);
    return Image(
      image: provider,
      width: width,
      height: height,
      fit: fit ?? BoxFit.cover,
      errorBuilder: (_, __, ___) => errorWidget ?? ColoredBox(color: Colors.grey.shade200, child: const Icon(Icons.broken_image)),
    );
  }
}
