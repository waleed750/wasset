// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:waseet/res/res.dart';

class MultiSelectDropDownField<T> extends StatelessWidget {
  const MultiSelectDropDownField({
    super.key,
    this.valueItem,
    required this.valueItems,
    required this.title,
    required this.onOptionSelected,
    this.dropdownHeight = 300,
    this.hint,
  });

  final List<ValueItem<T>>? valueItem;
  final List<ValueItem<T>> valueItems;
  final String title;
  final String? hint;
  final double dropdownHeight;
  final void Function(List<ValueItem<T>>) onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        MultiSelectDropDown<T>(
          // searchEnabled: true,
          selectedOptionTextColor: AppColors.primaryColor,
          onOptionSelected: onOptionSelected,
          onOptionRemoved: (index, item) {
            valueItem!.remove(item);
            onOptionSelected(valueItem!);
          },
          options: valueItems,
          hint: hint ?? '',
          chipConfig: const ChipConfig(
            wrapType: WrapType.wrap,
            backgroundColor: AppColors.primaryColor,
          ),
          dropdownHeight: dropdownHeight,
          optionTextStyle: TextStyle(fontSize: 16.sp),
          selectedOptionIcon: const Icon(Icons.check_circle),
          selectedOptions: valueItem ?? [],
        ),
      ],
    );
  }
}
