import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/custom_appbar.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/brokers/presentation/add_connection_request/widgets/add_connection_request_body.dart';
import 'package:waseet/features/brokers/presentation/update_connection_request/cubit/update_connection_request_cubit.dart';
import 'package:waseet/features/tahalf/presentation/create_tahalf/widgets/create_tahalf_body.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/communication_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

class UpdateConnectionRequestBody extends StatelessWidget {
  const UpdateConnectionRequestBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<UpdateConnectionRequestCubit,
          UpdateConnectionRequestState>(
        builder: (context, state) {
          return Column(
            children: [
              const CustomAppbar(title: 'تعديل طلب تواصل'),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'الغرض',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            PurposeButton(
                              selected: state.isForBuy,
                              onTap: () {
                                context
                                    .read<UpdateConnectionRequestCubit>()
                                    .setPurpose(isForBuy: true);
                              },
                              text: 'شراء',
                            ),
                            PurposeButton(
                              selected: !state.isForBuy,
                              onTap: () {
                                context
                                    .read<UpdateConnectionRequestCubit>()
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
                                .read<UpdateConnectionRequestCubit>()
                                .setCategory(
                                  value!.id!,
                                );
                          },
                          value: state.request!.category,
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
                            context
                                .read<UpdateConnectionRequestCubit>()
                                .setCity(
                                  value!.id,
                                );
                          },
                          value: state.request!.city,
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        WassetTextField(
                          value: state.request!.description,
                          title: 'الوصف',
                          maxLines: 4,
                          onChanged: (text) {
                            context
                                .read<UpdateConnectionRequestCubit>()
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
                                      .read<UpdateConnectionRequestCubit>()
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
                                      .read<UpdateConnectionRequestCubit>()
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
                                      .read<UpdateConnectionRequestCubit>()
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
                            text: 'تعديل',
                            onTap: state.status ==
                                    UpdateConnectionRequestStatus.loading
                                ? null
                                : () {
                                    context
                                        .read<UpdateConnectionRequestCubit>()
                                        .updateConnectionRequest();
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
