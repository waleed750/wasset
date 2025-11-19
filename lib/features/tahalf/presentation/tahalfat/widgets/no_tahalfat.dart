import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:waseet/constants/constants.dart';

class NoTahalfat extends StatelessWidget {
  const NoTahalfat({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Stack(
            children: [
              SvgPicture.asset(Constants.noTahalfat1),
              Positioned(
                left: 0,
                right: 0,
                bottom: 40,
                child: SvgPicture.asset(Constants.noTahalfat2),
              ),
            ],
          ),
          SizedBox(
            height: 44.h,
          ),
          Text(
            'لا توجد تحالفات',
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
