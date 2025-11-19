import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/res/res.dart';

class BrokerItemIcon extends StatelessWidget {
  const BrokerItemIcon({
    super.key,
    this.onTap,
    required this.icon,
  });
  final void Function()? onTap;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4.5).r,
        margin: const EdgeInsets.symmetric(horizontal: 2.5).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5).r,
          color: const Color.fromARGB(37, 156, 102, 255),
        ),
        child: Icon(
          icon,
          color: AppColors.primaryColor,
          size: 18.sp,
        ),
      ),
    );
  }
}
