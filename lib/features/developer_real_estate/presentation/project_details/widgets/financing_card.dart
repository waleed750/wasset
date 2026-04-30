import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/res/res.dart';

class FinancingCard extends StatelessWidget {
  const FinancingCard({super.key, 
    required this.bankName,
    this.bankLogo,
    this.description,
    this.monthlyInstallment,
    this.isSelected = false,
    this.onTap,
  });

  final String bankName;
  final String? bankLogo;
  final String? description;
  final String? monthlyInstallment;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.w),
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          border: Border.all(
            color: isSelected
                ? AppColors.primaryColor
                : Colors.grey.withOpacity(0.2),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? AppColors.primaryColor.withOpacity(0.08)
              : Colors.white,
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: AppColors.primaryColor.withOpacity(0.15),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            else
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                blurRadius: 4,
                offset: const Offset(0, 1),
              ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Bank Logo/Icon
            if (bankLogo != null && bankLogo!.isNotEmpty)
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6).r,
                  color: Colors.grey.shade100,
                ),
                child: Image.network(
                  bankLogo!,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.account_balance,
                      color: AppColors.primaryColor,
                      size: 20.sp,
                    );
                  },
                ),
              )
            else
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6).r,
                  color: AppColors.primaryColor.withOpacity(0.15),
                ),
                child: Icon(
                  Icons.account_balance,
                  color: AppColors.primaryColor,
                  size: 18.sp,
                ),
              ),
            SizedBox(height: 8.h),
            // Bank Name
            Text(
              bankName,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected ? AppColors.primaryColor : Colors.black87,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

