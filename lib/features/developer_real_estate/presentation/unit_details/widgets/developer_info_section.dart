import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_info_entity.dart';
import 'package:waseet/res/res.dart';

class DeveloperInfoSection extends StatelessWidget {
  const DeveloperInfoSection({
    super.key,
    required this.developer,
  });

  final DeveloperInfoEntity developer;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        border: Border.all(
          color: AppColors.primaryColor.withOpacity(0.2),
        ),
        color: AppColors.primaryColor.withOpacity(0.04),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Text(
            'بيانات المطور',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),

          // Logo + Name Row
          Row(
            children: [
              // Developer Logo
              ClipRRect(
                borderRadius: BorderRadius.circular(8).r,
                child: developer.logo != null && developer.logo!.isNotEmpty
                    ? Image.network(
                        developer.logo!,
                        width: 56.w,
                        height: 56.w,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _FallbackLogoIcon();
                        },
                      )
                    : _FallbackLogoIcon(),
              ),
              SizedBox(width: 12.w),
              // Developer Name
              Expanded(
                child: Text(
                  developer.name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),

          // Responsible Name
          if (developer.responsibleName?.isNotEmpty ?? false)
            _InfoRow(
              label: 'اسم المسؤول',
              value: developer.responsibleName!,
              icon: Icons.person_outline,
            ),
          if (developer.responsibleName?.isNotEmpty ?? false)
            SizedBox(height: 10.h),

          // Responsible Mobile
          if (developer.responsibleMobile?.isNotEmpty ?? false)
            _InfoRow(
              label: 'رقم المسؤول',
              value: developer.responsibleMobile!,
              icon: Icons.phone_outlined,
            ),
        ],
      ),
    );
  }
}

class _FallbackLogoIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.w,
      height: 56.w,
      color: AppColors.primaryColor.withOpacity(0.1),
      child: Icon(
        Icons.business,
        color: AppColors.primaryColor,
        size: 24.sp,
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18.sp,
          color: AppColors.primaryColor,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
