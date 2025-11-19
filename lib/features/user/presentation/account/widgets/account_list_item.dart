// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AccountListItem extends StatelessWidget {
  const AccountListItem({
    super.key,
    this.leading,
    this.leadingPath,
    required this.text,
    this.onTap,
  });

  final Widget? leading;
  final String? leadingPath;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      shadowColor: const Color(0x3A7432FF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          15,
        ).r,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
        ).r,
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            15,
          ).r,
        ),
        tileColor: Colors.white,
        leading: leading != null || leadingPath != null
            ? SizedBox(
                width: 18.w,
                height: 18.w,
                child: leading ??
                    SvgPicture.asset(
                      leadingPath!,
                      height: 16.w,
                      width: 16.w,
                    ),
              )
            : null,
        title: Text(
          text,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: const Color(0xff999999),
          size: 24.sp,
        ),
      ),
    );
  }
}
