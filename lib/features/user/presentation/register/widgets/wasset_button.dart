import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/res/res.dart';

class WassetButton extends StatelessWidget {
  const WassetButton({
    super.key,
    required this.text,
    this.onTap,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
  });

  final String text;
  final void Function()? onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8).r,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12,
        ).r,
      ),
      onPressed: isLoading ? null : onTap,
      child: !isLoading
          ? Text(
              text,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: textColor ?? Colors.white,
              ),
            )
          : const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
    );
  }
}
