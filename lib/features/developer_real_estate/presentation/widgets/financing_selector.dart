import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/features/developer_real_estate/presentation/project_details/widgets/financing_card.dart';
import 'package:waseet/res/res.dart';

/// Reusable financing selector used across project and unit details.
class FinancingSelector extends StatefulWidget {
  const FinancingSelector({
    super.key,
    required this.options,
  });

  final List<dynamic>? options;

  @override
  State<FinancingSelector> createState() => _FinancingSelectorState();
}

class _FinancingSelectorState extends State<FinancingSelector> {
  int? _selectedIndex;

  @override
  Widget build(BuildContext context) {
    final options = widget.options ?? [];
    if (options.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 110.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            itemBuilder: (context, index) {
              final option = options[index];
              var bankName = 'بنك';
              String? bankLogo;

              if (option is Map<String, dynamic>) {
                bankName = (option['bank_name'] ?? option['name'] ?? bankName) as String;
                bankLogo = option['bank_logo'] as String?;
              } else if (option is String) {
                bankName = option;
              }

              return FinancingCard(
                bankName: bankName,
                bankLogo: bankLogo,
                isSelected: _selectedIndex == index,
                onTap: () {
                  setState(() => _selectedIndex = index);
                },
              );
            },
          ),
        ),
        SizedBox(height: 12.h),
        if (_selectedIndex != null && _selectedIndex! < options.length)
          _buildDetails(options[_selectedIndex!])
        else
          const SizedBox.shrink(),
      ],
    );
  }

  Widget _buildDetails(dynamic option) {
    if (option is Map<String, dynamic>) {
      final bankName = option['bank_name'] as String? ?? option['name'] as String? ?? '';
      final accountName = option['account_name'] as String?;
      final accountNumber = option['account_number'] as String?;
      final additionalInfo = option['additional_info'] as String?;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: AppColors.primaryColor.withOpacity(0.06),
          border: Border.all(color: AppColors.primaryColor.withOpacity(0.15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bankName,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w700),
            ),
            if (accountName != null) ...[
              SizedBox(height: 8.h),
              Text(
                accountName,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700),
              ),
            ],
            if (accountNumber != null) ...[
              SizedBox(height: 8.h),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      accountNumber,
                      style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, size: 18.sp, color: AppColors.primaryColor),
                    onPressed: () async {
                      await Clipboard.setData(ClipboardData(text: accountNumber));
                      if (!mounted) return;
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('تم نسخ رقم الحساب'),
                          backgroundColor: Colors.green.shade600,
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.all(12.r),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
            if (additionalInfo != null) ...[
              SizedBox(height: 8.h),
              Text(
                additionalInfo,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey.shade700, height: 1.4),
              ),
            ],
          ],
        ),
      );
    }

    // Fallback for string option
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10).r,
        color: AppColors.primaryColor.withOpacity(0.06),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.15)),
      ),
      child: Text(
        option.toString(),
        style: TextStyle(fontSize: 14.sp, color: Colors.black87),
      ),
    );
  }
}
