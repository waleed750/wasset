import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/skeleton.dart';

class TahalfatSkeleton extends StatelessWidget {
  const TahalfatSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Skeleton(
          child: Container(
            margin: const EdgeInsets.all(10).r,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16).r,
              color: Colors.white,
            ),
          ),
        ),
        Skeleton(
          child: Container(
            margin: const EdgeInsets.all(10).r,
            height: 150.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16).r,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
