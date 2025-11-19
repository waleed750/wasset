import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waseet/constants/constants.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.text,
    required this.image,
    this.onTap,
  });
  final String text;
  final String image;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: (1.sw - 85) / 4,
        padding: const EdgeInsets.all(8).r,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0x3A86A8E7),
              blurRadius: 10.06,
              offset: Offset(0, 1.68),
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              image,
              height: 16.w,
              width: 16.w,
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              text,
              style: TextStyle(
                color: Constants.secondaryColor,
                fontSize: 10.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
