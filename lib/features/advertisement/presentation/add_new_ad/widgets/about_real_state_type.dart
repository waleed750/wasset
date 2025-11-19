// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/wasset_drop_down_form_field.dart';
import 'package:waseet/common_widgets/wasset_radio_button.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/cubit/add_new_ad_cubit.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/profile_text_field.dart';

class AboutRealStateType extends StatelessWidget {
  const AboutRealStateType({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAdCubit, AddNewAdState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'نوع الاعلان',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              child: Column(
                children: [
                  WassetRadioButton(
                    value: 'buy',
                    groupValue: state.addAdRequest.typeOfAdvertisement,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              typeOfAdvertisement: 'buy',
                            ),
                          );
                    },
                    title: 'بيع',
                  ),
                  WassetRadioButton(
                    value: 'rent',
                    groupValue: state.addAdRequest.typeOfAdvertisement,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              typeOfAdvertisement: 'rent',
                            ),
                          );
                    },
                    title: 'ايجار',
                  ),
                  WassetRadioButton(
                    value: 'investment',
                    groupValue: state.addAdRequest.typeOfAdvertisement,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              typeOfAdvertisement: 'investment',
                            ),
                          );
                    },
                    title: 'استثمار',
                  ),
                  WassetRadioButton(
                    value: 'daily_rent',
                    groupValue: state.addAdRequest.typeOfAdvertisement,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              typeOfAdvertisement: 'daily_rent',
                            ),
                          );
                    },
                    title: 'ايجار يومي',
                  ),
                  WassetRadioButton(
                    value: 'other',
                    groupValue: state.addAdRequest.typeOfAdvertisement,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              typeOfAdvertisement: 'other',
                            ),
                          );
                    },
                    title: 'غير ذلك',
                  ),
                ],
              ),
            ),
            if (state.addAdRequest.typeOfAdvertisement == 'other')
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ProfileTextField(
                  initialValue: state.addAdRequest.typeOfAdvertisementExtra,
                  text: 'نوع الاعلان',
                  hintText: 'اخرى',
                  onChanged: (value) {
                    context.read<AddNewAdCubit>().changeAdRequest(
                          state.addAdRequest.copyWith(
                            typeOfAdvertisementExtra: value,
                          ),
                        );
                  },
                ),
              ),
            const SizedBox(height: 16),
            WassetDropDownFormField(
              hint: 'شقة ، فيلا ، ارض ...',
              title: 'نوع العقار',
              items: state.categories,
              value: state.categories.firstOrNull,
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        categoryId: value!.id,
                      ),
                    );
              },
            ),
            const SizedBox(height: 16),
            WassetDropDownFormField(
              hint: 'اختر المدينة التي بها عقارك',
              title: 'المدينة',
              items: state.cities,
              value: state.cities.firstOrNull,
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeCity(value!.id);
              },
            ),
            const SizedBox(height: 16),
            WassetDropDownFormField(
              hint: 'اختر الحي',
              title: 'الحي',
              items: state.neighborhoods,
              value: state.neighborhoods.firstOrNull,
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        neighborhoodId: value!.id,
                      ),
                    );
              },
            ),
          ],
        );
      },
    );
  }
}
