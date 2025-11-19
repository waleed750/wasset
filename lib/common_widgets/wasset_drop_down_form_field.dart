import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/res/helper_method.dart';

class WassetDropDownFormField<T> extends StatelessWidget {
  const WassetDropDownFormField({
    super.key,
    required this.hint,
    required this.title,
    required this.items,
    this.value,
    this.onChanged,
  });

  final String hint;
  final String title;
  final List<T> items;
  final T? value;
  final ValueChanged<T?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          textAlign: TextAlign.right,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 10.h),
        DropdownButtonFormField(
          dropdownColor: Colors.white,
          hint: Text(
            hint,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
          decoration: InputDecoration(
            hintStyle: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 15,
            ).r,
            enabledBorder: HelperMethod.outlineInputBorder,
            focusedBorder: HelperMethod.outlineInputBorder,
            border: HelperMethod.outlineInputBorder,
          ),
          items: items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e.toString(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
          value: value,
        ),
      ],
    );
  }
}
