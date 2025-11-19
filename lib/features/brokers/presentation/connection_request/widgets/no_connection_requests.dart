import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waseet/res/assets/assets.gen.dart';

class NoConnectionRequests extends StatelessWidget {
  const NoConnectionRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 186, left: 124, right: 105).r,
      child: Column(
        children: [
          SvgPicture.asset(
            Assets.images.chatsIllustration.path,
          ),
          SizedBox(
            height: 44.h,
          ),
          Text(
            'لاتوجد طلبات تواصل',
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
