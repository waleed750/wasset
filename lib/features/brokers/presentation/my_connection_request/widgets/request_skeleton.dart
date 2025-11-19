import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/skeleton.dart';

class RequestSkeleton extends StatelessWidget {
  const RequestSkeleton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.h,
        ),
        Skeleton(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5).r,
            height: 230.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16).r,
              color: Colors.white,
            ),
          ),
        ),
        Skeleton(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5).r,
            height: 230.h,
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
