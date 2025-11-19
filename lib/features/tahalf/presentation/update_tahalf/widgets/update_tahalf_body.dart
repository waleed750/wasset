// ignore_for_file: strict_raw_type, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/tahalf/presentation/update_tahalf/update_tahalf.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/multi_select_drop_down_field.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/enums/tahalf_purpose_type.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

class UpdateTahalfBody extends StatelessWidget {
  const UpdateTahalfBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return BlocBuilder<UpdateTahalfCubit, UpdateTahalfState>(
          builder: (context, state) {
            if (state.status == UpdateTahalfStatus.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            WassetTextField(
                              value: state.tahalf!.name,
                              hintText: 'اختر اسم التحالف',
                              title: 'اسم التحالف',
                              onChanged: (value) {
                                context
                                    .read<UpdateTahalfCubit>()
                                    .setName(value);
                              },
                            ),
                            SizedBox(
                              height: 15.h,
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
                                'اختر المدينة',
                                style: TextStyle(
                                  color:
                                      const Color.fromARGB(196, 117, 117, 117),
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
                                context.read<UpdateTahalfCubit>().setCity(
                                      value!.id,
                                    );
                              },
                              value: state.tahalf!.city,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            MultiSelectDropDownField<CategoryEntity>(
                              onOptionSelected:
                                  (List<ValueItem<CategoryEntity>> value) {
                                context
                                    .read<UpdateTahalfCubit>()
                                    .setSelectedCategory(
                                      value.map((e) => e.value!).toList(),
                                    );
                              },
                              title: 'التخصص',
                              hint: 'اختر التخصص',
                              valueItems: state.categories
                                  .map(
                                    (e) => ValueItem(
                                      value: e,
                                      label: e.name ?? '',
                                    ),
                                  )
                                  .toList(),
                              valueItem: state.selectedCategories
                                  ?.map(
                                    (e) => ValueItem(
                                      value: e,
                                      label: e.name ?? '',
                                    ),
                                  )
                                  .toList(),
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            MultiSelectDropDownField(
                              dropdownHeight: 90.h,
                              onOptionSelected:
                                  (List<ValueItem<String>> value) {
                                context.read<UpdateTahalfCubit>().setBrokerType(
                                      value.map((e) => e.value!).toList(),
                                    );
                              },
                              title: 'نوع الوسطاء',
                              hint: 'اختر الوسطاء ',
                              valueItems: [
                                ...BrokerType.values.map(
                                  (e) => ValueItem(
                                    value: e.name,
                                    label: e.arabicName,
                                  ),
                                ),
                              ],
                              valueItem: state.tahalf!.wassetType
                                  ?.map(
                                    (e) => ValueItem(
                                      value: e,
                                      label: e == BrokerType.wasset.name
                                          ? BrokerType.wasset.arabicName
                                          : BrokerType.office.arabicName,
                                    ),
                                  )
                                  .toList(),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            if (state.tahalfType == TahalfType.private.name)
                              Column(
                                children: [
                                  WassetTextField(
                                    hintText:
                                        '  رمز سري للسماح بالانضمام للتحالف الخاص',
                                    title: 'الرمز السري للتحالف ',
                                    onChanged: (value) {
                                      context
                                          .read<UpdateTahalfCubit>()
                                          .setPassWord(value);
                                    },
                                  ),
                                  SizedBox(
                                    height: 15.h,
                                  ),
                                ],
                              ),
                            const Text('الغرض'),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(1).r,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15).r,
                                border: Border.all(
                                  color: AppColors.textFieldBorderColor,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomRadio(
                                    onChanged: (value) {
                                      context
                                          .read<UpdateTahalfCubit>()
                                          .setTahalfPurpose(
                                            TahalfPurposeType.sale.name,
                                          );
                                    },
                                    text: 'بيع',
                                    value: TahalfPurposeType.sale.name,
                                    groupValue: state.tahalfPurpose ??
                                        state.tahalf!.purpose,
                                  ),
                                  CustomRadio(
                                    onChanged: (value) {
                                      context
                                          .read<UpdateTahalfCubit>()
                                          .setTahalfPurpose(
                                            TahalfPurposeType.rent.name,
                                          );
                                    },
                                    text: 'ايجار',
                                    value: TahalfPurposeType.rent.name,
                                    groupValue: state.tahalfPurpose ??
                                        state.tahalf!.purpose,
                                  ),
                                  CustomRadio(
                                    onChanged: (value) {
                                      context
                                          .read<UpdateTahalfCubit>()
                                          .setTahalfPurpose(
                                            TahalfPurposeType.investment.name,
                                          );
                                    },
                                    text: 'استثمار',
                                    value: TahalfPurposeType.investment.name,
                                    groupValue: state.tahalfPurpose ??
                                        state.tahalf!.purpose,
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   height: 10.h,
                            // ),
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Checkbox(
                            //       activeColor: AppColors.primaryColor,
                            //       value: state.approval,
                            //       onChanged: (value) {
                            //         context
                            //             .read<UpdateTahalfCubit>()
                            //             .setapprovalValue(value!);
                            //       },
                            //     ),
                            //     SizedBox(
                            //       width: MediaQuery.sizeOf(context).width - 95,
                            //       child: const Text(
                            //         'الدخول في خدمة تحالف الوسطاء هي للأغراض العقارية المرخصة و أتحمل خلاف ذلك',
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            SizedBox(
                              height: 20.h,
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: WassetButton(
                                text: 'تعديل التحالف',
                                onTap: state.approval == false ||
                                        state.status ==
                                            UpdateTahalfStatus.loading
                                    ? null
                                    : () {
                                        context
                                            .read<UpdateTahalfCubit>()
                                            .updateTahalf();
                                      },
                              ),
                            ),
                            SizedBox(
                              height: 50.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
    required this.groupValue,
  });
  final Object value;
  final Object? groupValue;
  final void Function(Object?)? onChanged;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          activeColor: AppColors.primaryColor,
          onChanged: onChanged,
        ),
        Text(
          text,
        ),
      ],
    );
  }
}
