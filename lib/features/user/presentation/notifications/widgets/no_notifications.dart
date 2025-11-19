import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waseet/constants/constants.dart';

class NoNotifications extends StatelessWidget {
  const NoNotifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 186, left: 124, right: 105).r,
      child: Column(
        children: [
          SvgPicture.asset(
            Constants.bigBell,
          ),
          SizedBox(
            height: 44.h,
          ),
          Text(
            'لا توجد إشعارات',
            style: TextStyle(
              fontSize: 19.sp,
              color: const Color.fromRGBO(128, 131, 163, 1),
            ),
          ),
        ],
      ),
    );
  }
}
