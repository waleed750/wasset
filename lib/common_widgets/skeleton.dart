import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.height,
    this.width,
    this.child,
  });

  final double? height;
  final double? width;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color.fromARGB(134, 208, 208, 208),
      highlightColor: const Color.fromARGB(255, 255, 255, 255),
      child: child ??
          Container(
            height: height,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10).r,
              color: Colors.grey.withOpacity(0.5),
            ),
          ),
    );
  }
}
