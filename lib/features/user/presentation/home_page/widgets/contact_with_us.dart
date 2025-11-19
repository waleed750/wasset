import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/res/helper_method.dart';

class ContactWithUs extends StatelessWidget {
  const ContactWithUs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HelperMethod.contactUs(context);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20).r,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(94, 158, 158, 158),
              blurRadius: 5,
            ),
          ],
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'توجد مشكلة؟ تواصل معنا',
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 12.sp,
              ),
            ),
            SvgPicture.asset(
              Constants.contactWithUs,
              height: 18.w,
              width: 18.w,
            ),
          ],
        ),
      ),
    );
  }
}
