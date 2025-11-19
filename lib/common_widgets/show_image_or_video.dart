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
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (!widget.path.isImage) {
      if (widget.path.contains('http')) {
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path))
          ..initialize().then((_) {
            setState(() {});
          });
      } else {
        _controller = VideoPlayerController.file(File(widget.path))
          ..initialize().then((_) {
            setState(() {});
          });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isImage = widget.path.isImage;
    final isNetwork = widget.path.contains('http');
    if (isImage) {
      if (isNetwork) {
        return Image.network(
          widget.path,
          fit: BoxFit.cover,
          height: widget.height,
          width: widget.width,
        );
      } else {
        return Image.file(
          File(widget.path),
          fit: BoxFit.cover,
          height: widget.height,
          width: widget.width,
        );
      }
    } else {
      return _controller.value.isInitialized
          ? AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(
                _controller,
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            );
    }
  }
}
