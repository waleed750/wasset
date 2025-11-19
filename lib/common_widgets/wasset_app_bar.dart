import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WassetAppBar extends StatelessWidget implements PreferredSizeWidget {
  const WassetAppBar({
    super.key,
    required this.title,
    this.bottom,
    this.showBackButton = true,
  });

  final String title;
  final PreferredSizeWidget? bottom;
  final bool showBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: const Radius.circular(20).r,
        ),
      ),
      automaticallyImplyLeading: showBackButton,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      centerTitle: true,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50);
}
