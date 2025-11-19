import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/skeleton.dart';

class AdSkeleton extends StatelessWidget {
  const AdSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Skeleton(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16).r,
              color: Colors.white,
            ),
          ),
        ),
        Skeleton(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            height: 120.h,
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
