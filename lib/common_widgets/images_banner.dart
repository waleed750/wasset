// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/show_image_or_video.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/res/res.dart';

class ImagesBanner extends StatefulWidget {
  const ImagesBanner({
    super.key,
    required this.images,
    this.showFullScreen = true,
  });

  final List<String> images;
  final bool showFullScreen;

  @override
  State<ImagesBanner> createState() => _ImagesBannerState();
}

class _ImagesBannerState extends State<ImagesBanner> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.showFullScreen) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  appBar: const WassetAppBar(
                    title: '',
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: Center(
                          child: ImagesBanner(
                            images: widget.images,
                            showFullScreen: false,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }
      },
      child: Stack(
        children: [
          Positioned.fill(
            child: ImageSlideshow(
              height: double.infinity,
              indicatorColor: Colors.transparent,
              indicatorBackgroundColor: Colors.transparent,
              onPageChanged: (value) {
                setState(() {
                  _currentIndex = value;
                });
              },
              children: widget.images.map(
                (e) {
                  return ShowImageOrVideo(
                    path: e,
                  );
                },
              ).toList(),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.images.asMap().entries.map(
                  (e) {
                    return Container(
                      width: 8.w,
                      height: 8.w,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 2,
                      ).r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentIndex == e.key
                            ? AppColors.primaryColor
                            : Colors.grey,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  bool get isImage =>
      endsWith('.jpg') ||
      endsWith('.jpeg') ||
      endsWith('.png') ||
      endsWith('.gif') ||
      endsWith('.webp');
}
