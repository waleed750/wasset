import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/skeleton.dart';

class ShimmerCities extends StatelessWidget {
  const ShimmerCities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = 0.25.sw;
    final width = 0.25.sw;
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          ...List.generate(
            4,
            (index) => Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Skeleton(
                      height: height,
                      width: width,
                    ),
                    SizedBox(height: 10.h),
                    Skeleton(
                      height: height,
                      width: width,
                    ),
                    SizedBox(height: 10.h),
                    Skeleton(
                      height: height,
                      width: width,
                    ),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
