import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key, required this.onTap});
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: (1.sh / 6).h,
        ),
        SvgPicture.asset(Constants.errorPage),
        SizedBox(
          height: 40.h,
        ),
        Text(
          'نعتذر منك',
          style: TextStyle(
            color: const Color(0xff8083A3),
            fontSize: 19.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'يبدو ان فيه مشكلة بسيطة حصلت!',
          style: TextStyle(
            color: const Color(0xff8083A3),
            fontSize: 19.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          'قم بإعادة تحميل الصفحة  ',
          style: TextStyle(
            color: const Color(0xff8083A3),
            fontSize: 19.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          ' او يمكنك التواصل معنا لمساعدتك في حل المشكلة',
          style: TextStyle(
            color: const Color(0xff8083A3),
            fontSize: 19.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: (1.sw / 2).w,
          child: WassetButton(
            text: 'اعادة التحميل',
            onTap: onTap,
          ),
        ),
      ],
    );
  }
}
