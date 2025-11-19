// ignore_for_file: strict_raw_type, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/cubit/cubit.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/multi_select_drop_down_field.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/enums/tahalf_purpose_type.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

class CreateTahalfBody extends StatelessWidget {
  const CreateTahalfBody({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTahalfCubit, CreateTahalfState>(
      builder: (context, state) {
        if (state.status != CreateTahalfStatus.loaded) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20).r,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WassetTextField(
                    hintText: 'اختر اسم التحالف',
                    title: 'اسم التحالف',
                    onChanged: (value) {
                      context.read<CreateTahalfCubit>().setName(value);
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
                      context.read<CreateTahalfCubit>().setCity(
                            value!.id,
                          );
                    },
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  MultiSelectDropDownField(
                    onOptionSelected: (List<ValueItem<CategoryEntity>> value) {
                      context.read<CreateTahalfCubit>().setSelectedCategory(
                            value.map((e) => e.value!).toList(),
                          );
                    },
                    title: 'التخصص',
                    hint: 'اختر التخصص',
                    valueItems: [
                      ...state.categories.map(
                        (e) => ValueItem(
                          value: e,
                          label: e.name ?? '',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  MultiSelectDropDownField(
                    dropdownHeight: 90.h,
                    onOptionSelected: (List<ValueItem<BrokerType>> value) {
                      context.read<CreateTahalfCubit>().setBrokerType(
                            value.map((e) => e.value!).toList(),
                          );
                    },
                    title: 'نوع الوسطاء',
                    hint: 'اختر الوسطاء ',
                    valueItems: [
                      ...BrokerType.values.map(
                        (e) => ValueItem(
                          value: e,
                          label: e.arabicName,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  // tahalf categories
                  // MultiSelectDropDownField(
                  //   onOptionSelected:
                  //       (List<ValueItem<CategoryEntity>> value) {
                  //     context.read<CreateTahalfCubit>().setSelectedCategory(
                  //           value.map((e) => e.value!).toList(),
                  //         );
                  //   },
                  //   title: 'تخصص التحالف',
                  //   hint: 'اختر تخصص التحالف',
                  //   valueItems: [
                  //     ...context
                  //             .watch<CreateTahalfCubit>()
                  //             .state
                  //             .subCategories
                  //             ?.map(
                  //               (e) => ValueItem(
                  //                 value: e,
                  //                 label: e.name ?? '',
                  //               ),
                  //             ) ??
                  //         <ValueItem<CategoryEntity>>[],
                  //   ],
                  // ),

                  // SizedBox(
                  //   height: 15.h,
                  // ),
                  if (state.tahalfType == TahalfType.private.name)
                    Column(
                      children: [
                        WassetTextField(
                          hintText: '  رمز سري للسماح بالانضمام للتحالف الخاص',
                          title: 'الرمز السري للتحالف ',
                          onChanged: (value) {
                            context
                                .read<CreateTahalfCubit>()
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
                            context.read<CreateTahalfCubit>().setTahalfPurpose(
                                  TahalfPurposeType.sale,
                                );
                          },
                          text: 'بيع',
                          value: TahalfPurposeType.sale,
                          groupValue: state.tahalfPurpose,
                        ),
                        CustomRadio(
                          onChanged: (value) {
                            context.read<CreateTahalfCubit>().setTahalfPurpose(
                                  TahalfPurposeType.rent,
                                );
                          },
                          text: 'ايجار',
                          value: TahalfPurposeType.rent,
                          groupValue: state.tahalfPurpose,
                        ),
                        CustomRadio(
                          onChanged: (value) {
                            context.read<CreateTahalfCubit>().setTahalfPurpose(
                                  TahalfPurposeType.investment,
                                );
                          },
                          text: 'استثمار',
                          value: TahalfPurposeType.investment,
                          groupValue: state.tahalfPurpose,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor: AppColors.primaryColor,
                        value: state.approval,
                        onChanged: (value) {
                          context
                              .read<CreateTahalfCubit>()
                              .setapprovalValue(value!);
                        },
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width - 95,
                        child: const Text(
                          'الدخول في خدمة تحالف الوسطاء هي للأغراض العقارية المرخصة و أتحمل خلاف ذلك',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: WassetButton(
                      text: 'إنشاء تحالف',
                      onTap: state.approval == false ||
                              state.status == CreateTahalfStatus.loading
                          ? null
                          : () {
                              context.read<CreateTahalfCubit>().createTahalf();
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
