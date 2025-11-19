import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class NoItem extends StatelessWidget {
  const NoItem({super.key, required this.image, required this.text});
  final String image;
  final String text;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          SvgPicture.asset(image),
          SizedBox(
            height: 44.h,
          ),
          Text(
            text,
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
