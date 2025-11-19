import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/router/screens.dart';

class HomeBrokersButton extends StatelessWidget {
  const HomeBrokersButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ).r,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'وسطاء المملكة',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15.sp,
            ),
          ),
          GestureDetector(
            onTap: () {
              context.pushNamed(
                Screens.kingdomBroker.name,
              );
            },
            child: Row(
              children: [
                Text(
                  'الكل',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  size: 12.sp,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
