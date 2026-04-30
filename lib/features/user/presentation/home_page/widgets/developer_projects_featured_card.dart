import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class DeveloperProjectsFeaturedCard extends StatelessWidget {
  const DeveloperProjectsFeaturedCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(Screens.developerRealEstateEntry.name);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16).r,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0x3A86A8E7),
              blurRadius: 10.06,
              offset: Offset(0, 1.68),
            ),
          ],
          borderRadius: BorderRadius.circular(15).r,
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Arrow indicator (left side - RTL)
            Icon(
              Icons.arrow_forward_ios,
              size: 18.sp,
              color: AppColors.primaryColor,
            ),
            // Content (center)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'مشاريع المطورين',
                      style: TextStyle(
                        color: AppColors.primaryTextColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'استعرض عروض ومشاريع المطورين العقاريين',
                      style: TextStyle(
                        color: AppColors.secondaryTextColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
            // Icon (right side - RTL end)
            Container(
              padding: const EdgeInsets.all(10).r,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12).r,
              ),
              child: Assets.icons.apartment.svg(
                width: 24.w,
                height: 24.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
