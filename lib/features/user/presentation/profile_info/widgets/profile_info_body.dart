// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/entities/wasset_user.dart';
import 'package:waseet/features/user/presentation/profile_info/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/multi_select_drop_down_field.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/profile_text_field.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/enums/broker_type.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/res/res.dart';

/// {@template profile_info_body}
/// Body of the ProfileInfoPage.
///
/// Add what it does
/// {@endtemplate}
class ProfileInfoBody extends StatelessWidget {
  /// {@macro profile_info_body}
  const ProfileInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, appState) {
          final userType = appState.user?.type;
          final user = appState.user?.profile;
          return BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
            builder: (context, state) {
              if (state.status == ProfileInfoStatus.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Align(
                        child: Stack(
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white,
                              child: user?.profileImage != null
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.network(
                                        user?.profileImage ?? '',
                                        width: 100.w,
                                        height: 100.w,
                                        fit: BoxFit.cover,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 50,
                                      color: AppColors.primaryColor,
                                    ),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 22,
                                child: CircleAvatar(
                                  radius: 16,
                                  backgroundColor: const Color(0xFFEAD6FF),
                                  child: CircleAvatar(
                                    radius: 10,
                                    backgroundColor: AppColors.primaryColor,
                                    child: InkWell(
                                      onTap: () async {
                                        final picked =
                                            await ImagePicker().pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 100,
                                          maxWidth: 400,
                                          maxHeight: 600,
                                        );

                                        if (picked != null) {
                                          final file = File(picked.path);
                                          await context
                                              .read<ProfileInfoCubit>()
                                              .update(
                                                file,
                                              );
                                        }
                                      },
                                      child: const Icon(
                                        Icons.edit,
                                        color: Color(0xFFEAD6FF),
                                        size: 12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileTextField(
                        text: 'الاسم',
                        initialValue: state.name ?? user?.name,
                        onChanged: (value) {
                          context.read<ProfileInfoCubit>().setName(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileTextField(
                        text:
                            'رقم الهوية${appState.user?.profile?.isVerified != true ? 'ّ' : ' (تم التحقق)'}',
                        initialValue:
                            state.identityNumber ?? user?.identityNumber,
                        onChanged: (value) {
                          context
                              .read<ProfileInfoCubit>()
                              .setIdentityNumber(value);
                        },
                        enabled: appState.user?.profile?.isVerified != true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ProfileTextField(
                        text: 'رقم الهاتف',
                        initialValue: state.phone ?? user?.phone,
                        onChanged: (value) {
                          context.read<ProfileInfoCubit>().setPhone(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (userType == UserType.wasset) ...[
                        ProfileTextField(
                          text: 'رقم الرخصة',
                          initialValue:
                              state.licenseNumber ?? user?.licenseNumber ?? '',
                          onChanged: (value) {
                            context
                                .read<ProfileInfoCubit>()
                                .setLicenseNumber(value);
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      ProfileTextField(
                        text: 'البريد الالكتروني',
                        initialValue: state.email.value.isNotEmpty
                            ? state.email.value
                            : user?.email ?? '',
                        onChanged: (value) {
                          context.read<ProfileInfoCubit>().setEmail(value);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      if (userType == UserType.wasset) ...[
                        const Text(
                          'تخصص الوسيط',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
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
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            context
                                .read<ProfileInfoCubit>()
                                .setSelectedCategory(value!);
                          },
                          value: state.selectedCategory ??
                              state.categories.singleWhere(
                                (element) =>
                                    element.id ==
                                    user?.wassetSpecialization?.firstOrNull
                                        ?.mainCategory,
                                orElse: () => state.categories.first,
                              ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      if (userType == UserType.wasset) ...[
                        // if (state.selectedCategory != null) ...[
                        //   MultiSelectDropDownField(
                        //     valueItem: state.brokerSpecialization
                        //         ?.map(
                        //           (e) => ValueItem(
                        //             value: e,
                        //             label: e.name ?? '',
                        //           ),
                        //         )
                        //         .toList(),
                        //     onOptionSelected:
                        //         (List<ValueItem<CategoryEntity>> value) {
                        //       context
                        //           .read<ProfileInfoCubit>()
                        //           .setBrokerSpecialization(
                        //             value.map((e) => e.value!).toList(),
                        //           );
                        //     },
                        //     title: 'التخصص الفرعي للوسيط',
                        //     valueItems: state.selectedCategory!.subCategory!
                        //         .map(
                        //           (e) => ValueItem(
                        //             value: e,
                        //             label: e.name ?? '',
                        //           ),
                        //         )
                        //         .toList(),
                        //   ),
                        //   const SizedBox(
                        //     height: 20,
                        //   ),
                        // ],

                        const Text(
                          'نوع الوسيط',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            enabledBorder: HelperMethod.outlineInputBorder,
                            focusedBorder: HelperMethod.outlineInputBorder,
                            border: HelperMethod.outlineInputBorder,
                          ),
                          items: [
                            ...BrokerType.values.map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e.arabicName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                          onChanged: (value) {
                            context
                                .read<ProfileInfoCubit>()
                                .setBrokerType(value!);
                          },
                          value: user?.officeType?.toBrokerType ??
                              BrokerType.wasset,
                        ),
                        if (state.officeType == BrokerType.office) ...[
                          const SizedBox(
                            height: 20,
                          ),
                          ProfileTextField(
                            text: 'اسم المكتب',
                            initialValue: user?.officeName,
                            onChanged: (value) {
                              context
                                  .read<ProfileInfoCubit>()
                                  .setOfficeName(value);
                            },
                          ),
                        ],
                        // drop down button
                        const SizedBox(
                          height: 20,
                        ),
                        MultiSelectDropDownField(
                          valueItem: context
                              .watch<AppBloc>()
                              .state
                              .user
                              ?.profile
                              ?.cities
                              ?.map(
                                (e) => ValueItem(
                                  value: e,
                                  label: e.name,
                                ),
                              )
                              .toList(),
                          onOptionSelected:
                              (List<ValueItem<CitiesEntity>> value) {
                            context
                                .read<ProfileInfoCubit>()
                                .setCities(value.map((e) => e.value!).toList());
                          },
                          title: 'المدن',
                          valueItems: state.cities
                              .map(
                                (e) => ValueItem(
                                  value: e,
                                  label: e.name,
                                ),
                              )
                              .toList(),
                        ),

                        const SizedBox(
                          height: 20,
                        ),
                      ],
                      SizedBox(
                        width: double.infinity,
                        child: WassetButton(
                          text: 'حفظ',
                          onTap: () {
                            context.read<ProfileInfoCubit>().updateProfile();
                          },
                          isLoading: state.status == ProfileInfoStatus.updating,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
