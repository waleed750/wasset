// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/kingdom_broker_cubit.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

class BrokerBottomSheet extends StatefulWidget {
  const BrokerBottomSheet({
    super.key,
  });

  @override
  State<BrokerBottomSheet> createState() => _BrokerBottomSheetState();
}

class _BrokerBottomSheetState extends State<BrokerBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KingdomBrokerCubit, KingdomBrokerState>(
      builder: (context, state) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) => Container(
            height: (MediaQuery.sizeOf(context).height / 2).h,
            padding: const EdgeInsets.all(20).r,
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
                        context.read<KingdomBrokerCubit>().brokersUnfiltering();
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
                              value: BrokerType.office,
                              child: Text(BrokerType.office.arabicName),
                            ),
                            DropdownMenuItem(
                              value: BrokerType.wasset,
                              child: Text(BrokerType.wasset.arabicName),
                            ),
                          ],
                          onChanged: (value) {
                            context
                              ..read<KingdomBrokerCubit>()
                                  .setSelectedType(value)
                              ..read<KingdomBrokerCubit>().brokersFiltering();
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'جنس الوسيط',
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
                          items: const [
                            DropdownMenuItem(
                              value: 'ذكر',
                              child: Text('ذكر'),
                            ),
                            DropdownMenuItem(
                              value: 'أنثى',
                              child: Text('أنثى'),
                            ),
                          ],
                          onChanged: (value) {
                            context
                              ..read<KingdomBrokerCubit>()
                                  .setSelectedGender(value ?? '')
                              ..read<KingdomBrokerCubit>().brokersFiltering();
                          },
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text(
                          'تخصص الوسيط',
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
                          //TODO:  😬لما يختار التخصصات الفرعية عايزة أغير الهنت لي اسم التخصص الرئيسي
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
                          items: state.categories
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          final subSelected =
                                              <CategoryEntity>[];
                                          return StatefulBuilder(
                                            builder: (
                                              BuildContext dialogContext,
                                              setState,
                                            ) =>
                                                Dialog(
                                              child: Container(
                                                color: Colors.white,
                                                padding: const EdgeInsets.all(
                                                  10,
                                                ).r,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const SizedBox(),
                                                        Text(
                                                          e.name!,
                                                          style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 20.sp,
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(
                                                              subSelected.clear,
                                                            );
                                                          },
                                                          child: Text(
                                                            'مسح',
                                                            style: TextStyle(
                                                              fontSize: 15.sp,
                                                              color: AppColors
                                                                  .primaryColor,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 10.h,
                                                    ),
                                                    const Divider(
                                                      color: AppColors
                                                          .primaryColor,
                                                      thickness: 2,
                                                    ),
                                                    Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: List.generate(
                                                        e.subCategory!.length,
                                                        (index) {
                                                          return Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Text(
                                                                e
                                                                    .subCategory![
                                                                        index]
                                                                    .name!,
                                                              ),
                                                              Checkbox(
                                                                activeColor:
                                                                    AppColors
                                                                        .primaryColor,
                                                                value: subSelected
                                                                    .contains(
                                                                  e.subCategory![
                                                                      index],
                                                                ),
                                                                onChanged:
                                                                    (value) {
                                                                  if (subSelected
                                                                      .contains(
                                                                    e.subCategory![
                                                                        index],
                                                                  )) {
                                                                    setState(
                                                                        () {
                                                                      subSelected
                                                                          .remove(
                                                                        e.subCategory![
                                                                            index],
                                                                      );
                                                                    });
                                                                  } else {
                                                                    setState(
                                                                        () {
                                                                      subSelected
                                                                          .add(
                                                                        e.subCategory![
                                                                            index],
                                                                      );
                                                                    });
                                                                  }
                                                                },
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      child: WassetButton(
                                                        onTap: () {
                                                          context
                                                            ..read<KingdomBrokerCubit>()
                                                                .setSelectedCategory(
                                                              subSelected,
                                                            )
                                                            ..read<KingdomBrokerCubit>()
                                                                .brokersFiltering()
                                                            ..pop()
                                                            ..pop();
                                                        },
                                                        text: 'حفظ',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10).r,
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color.fromARGB(
                                              170,
                                              115,
                                              50,
                                              255,
                                            ),
                                            blurRadius: 5,
                                            offset: Offset(0, 1.68),
                                          ),
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(10).r,
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            e.name ?? '',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_back_ios_new,
                                            size: 12.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {},
                        ),
                        SizedBox(
                          height: 10.h,
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
                              // ..pushNamed(
                              //   Screens.brokerResult.name,
                              //   extra: context.read<KingdomBrokerCubit>(),
                              // );
                            },
                            text: ' عرض النتائج (${state.brokers.length})اعلان',
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
