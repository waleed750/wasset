// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:waseet/common_widgets/images_banner.dart';

class ShowImageOrVideo extends StatefulWidget {
  const ShowImageOrVideo({
    super.key,
    required this.path,
    this.height,
    this.width,
  });

  final String path;
  final double? height;
  final double? width;

  @override
  State<ShowImageOrVideo> createState() => _ShowImageOrVideoState();
}

class _ShowImageOrVideoState extends State<ShowImageOrVideo> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    if (!widget.path.isImage) {
      if (widget.path.contains('http')) {
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path))
          ..initialize().then((_) {
            if (mounted) setState(() {});
          });
      } else {
        _controller = VideoPlayerController.file(File(widget.path))
          ..initialize().then((_) {
            if (mounted) setState(() {});
          });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isImage = widget.path.isImage;
    final isNetwork = widget.path.contains('http');
    if (isImage) {
      if (isNetwork) {
        return _ZoomableImage(
          height: widget.height,
          width: widget.width,
          child: Image.network(
            widget.path,
            fit: BoxFit.contain,
            height: widget.height,
            width: widget.width,
            errorBuilder: (_, __, ___) => ColoredBox(
              color: Colors.grey.shade200,
              child: const Icon(Icons.broken_image),
            ),
          ),
        );
      } else {
        // Support file:// URIs as well as plain paths.
        var filePath = widget.path;
        if (filePath.startsWith('file://')) {
          try {
            filePath = Uri.parse(filePath).toFilePath();
          } catch (_) {}
        }

        return _ZoomableImage(
          height: widget.height,
          width: widget.width,
          child: Image.file(
            File(filePath),
            fit: BoxFit.cover,
            height: widget.height,
            width: widget.width,
            errorBuilder: (_, __, ___) => ColoredBox(
              color: Colors.grey.shade200,
              child: const Icon(Icons.broken_image),
            ),
          ),
        );
      }
    } else {
      final controller = _controller;
      return controller != null && controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: VideoPlayer(
                controller,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
    }
  }
}

class _ZoomableImage extends StatelessWidget {
  const _ZoomableImage({
    required this.child,
    this.height,
    this.width,
  });

  final Widget child;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: InteractiveViewer(
        minScale: 1,
        maxScale: 4,
        child: Center(child: child),
      ),
    );
  }
}
