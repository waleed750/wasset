import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/custom_appbar.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/brokers/presentation/add_connection_request/cubit/add_connection_request_cubit.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/widgets/create_tahalf_body.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/communication_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

class AddConnectionRequestBody extends StatelessWidget {
  const AddConnectionRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AddConnectionRequestCubit, AddConnectionRequestState>(
        builder: (context, state) {
          return Column(
            children: [
              const CustomAppbar(title: 'نموذج طلب تواصل'),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20).r,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'الغرض',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PurposeButton(
                              selected: state.isForBuy,
                              onTap: () {
                                context
                                    .read<AddConnectionRequestCubit>()
                                    .setPurpose(isForBuy: true);
                              },
                              text: 'شراء',
                            ),
                            PurposeButton(
                              selected: !state.isForBuy,
                              onTap: () {
                                context
                                    .read<AddConnectionRequestCubit>()
                                    .setPurpose(isForBuy: false);
                              },
                              text: 'ايجار',
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Text(
                          'نوع العقار',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        DropdownButtonFormField(
                          dropdownColor: Colors.white,
                          hint: Text(
                            'اختر نوع العقار',
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
                                    e.name ?? '',
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
                                .read<AddConnectionRequestCubit>()
                                .setCategory(
                                  value!.id!,
                                );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Text(
                          'المدينة',
                          style: TextStyle(fontWeight: FontWeight.bold),
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
                            context.read<AddConnectionRequestCubit>().setCity(
                                  value!.id,
                                );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        WassetTextField(
                          title: 'الوصف',
                          maxLines: 4,
                          onChanged: (text) {
                            context
                                .read<AddConnectionRequestCubit>()
                                .setDescription(
                                  text,
                                );
                          },
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        const Text(
                          'كيف تفضل طريقة التواصل',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
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
                                      .read<AddConnectionRequestCubit>()
                                      .setCommunitionMethod(
                                        CommunicationMethod.message,
                                      );
                                },
                                text: 'محادثة',
                                value: CommunicationMethod.message,
                                groupValue: state.communicationMethod,
                              ),
                              CustomRadio(
                                onChanged: (value) {
                                  context
                                      .read<AddConnectionRequestCubit>()
                                      .setCommunitionMethod(
                                        CommunicationMethod.whats,
                                      );
                                },
                                text: 'واتس',
                                value: CommunicationMethod.whats,
                                groupValue: state.communicationMethod,
                              ),
                              CustomRadio(
                                onChanged: (value) {
                                  context
                                      .read<AddConnectionRequestCubit>()
                                      .setCommunitionMethod(
                                        CommunicationMethod.call,
                                      );
                                },
                                text: 'اتصال',
                                value: CommunicationMethod.call,
                                groupValue: state.communicationMethod,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30.h),
                        SizedBox(
                          width: double.infinity,
                          child: WassetButton(
                            text: 'ارسال',
                            onTap: state.status ==
                                    AddConnectionRequestStatus.loading
                                ? null
                                : () {
                                    context
                                        .read<AddConnectionRequestCubit>()
                                        .addConnectionRequest();
                                  },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class PurposeButton extends StatelessWidget {
  const PurposeButton({
    super.key,
    this.onTap,
    required this.text,
    required this.selected,
  });
  final void Function()? onTap;
  final String text;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: MediaQuery.sizeOf(context).width < 500
            ? (MediaQuery.sizeOf(context).width / 3).w
            : 200.w,
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : Colors.white,
          border: Border.all(
            color: selected
                ? AppColors.primaryColor
                : AppColors.secondaryTextColor,
          ),
          borderRadius: BorderRadius.circular(18).r,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(color: selected ? Colors.white : null),
          ),
        ),
      ),
    );
  }
}
