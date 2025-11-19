// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/features/tahalf/presentation/tahalfat/my_tahalfat.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

class TahalfatBottomSheet extends StatefulWidget {
  const TahalfatBottomSheet({
    super.key,
  });

  @override
  State<TahalfatBottomSheet> createState() => _TahalfatBottomSheetState();
}

class _TahalfatBottomSheetState extends State<TahalfatBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TahalfatCubit, TahalfatState>(
      builder: (context, state) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) => Container(
            height: MediaQuery.sizeOf(context).height * 3 / 5,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 5),
                  spreadRadius: 5,
                  blurRadius: 10,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: const Radius.circular(16).r,
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Text(
                      'بحث',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20.sp,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.read<TahalfatCubit>().tahalfatUnfiltering();
                      },
                      child: Text(
                        'مسح',
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'نوع التحالف',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: const Text('اختار'),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ).r,
                            enabledBorder: HelperMethod.outlineInputBorder,
                            focusedBorder: HelperMethod.outlineInputBorder,
                            border: HelperMethod.outlineInputBorder,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: TahalfType.public,
                              child: Text(TahalfType.public.arName),
                            ),
                            DropdownMenuItem(
                              value: TahalfType.private,
                              child: Text(TahalfType.private.arName),
                            ),
                          ],
                          onChanged: (value) {
                            context
                              ..read<TahalfatCubit>().setTahalfType(value!.name)
                              ..read<TahalfatCubit>().tahalfatFiltering();
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          ' تخصص التحالف',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: Text(
                            'اختر التخصص',
                            style: TextStyle(
                              color: const Color.fromARGB(196, 117, 117, 117),
                              fontSize: 14.sp,
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
                          items: state.categories
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name!,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            context
                              ..read<TahalfatCubit>().setSelectedCategory(
                                value!,
                              )
                              ..read<TahalfatCubit>().tahalfatFiltering();
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'المدينة',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: Text(
                            'اختر التخصص',
                            style: TextStyle(
                              color: const Color.fromARGB(196, 117, 117, 117),
                              fontSize: 14.sp,
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
                          items: state.cities
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(
                                    e.name,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            context
                              ..read<TahalfatCubit>().setCity(
                                value!,
                              )
                              ..read<TahalfatCubit>().tahalfatFiltering();
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'نوع الوسيط',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: const Text('اختار'),
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ).r,
                            enabledBorder: HelperMethod.outlineInputBorder,
                            focusedBorder: HelperMethod.outlineInputBorder,
                            border: HelperMethod.outlineInputBorder,
                          ),
                          items: [
                            DropdownMenuItem(
                              value: BrokerType.wasset,
                              child: Text(BrokerType.wasset.arabicName),
                            ),
                            DropdownMenuItem(
                              value: BrokerType.office,
                              child: Text(BrokerType.office.arabicName),
                            ),
                          ],
                          onChanged: (value) {
                            context
                              ..read<TahalfatCubit>().setBrokerType(value!.name)
                              ..read<TahalfatCubit>().tahalfatFiltering();
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: WassetButton(
                            backgroundColor: AppColors.primaryColor,
                            onTap: () {
                              context.pop();
                            },
                            text:
                                ' عرض النتائج (${state.tahalfList.length})اعلان',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
