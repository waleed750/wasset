// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_drop_down_form_field.dart';
import 'package:waseet/common_widgets/wasset_radio_button.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/profile_text_field.dart';

class RealStateDetailsPage extends StatelessWidget {
  const RealStateDetailsPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAdCubit, AddNewAdState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileTextField(
              text: 'مساحة الارض',
              initialValue: state.addAdRequest.landSpace.toString(),
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        landSpace: int.tryParse(value),
                      ),
                    );
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ProfileTextField(
              text: 'سعر المتر',
              initialValue: state.addAdRequest.meterPrice.toString(),
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        meterPrice: int.tryParse(value),
                      ),
                    );
              },
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            const Text(
              'هل يوجد نزاع على العقار؟',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WassetRadioButton(
                    value: true,
                    groupValue: state.addAdRequest.propertyDispute,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              propertyDispute: value,
                            ),
                          );
                    },
                    title: 'نعم',
                  ),
                  WassetRadioButton(
                    value: false,
                    groupValue: state.addAdRequest.propertyDispute,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              propertyDispute: value,
                            ),
                          );
                    },
                    title: 'لا',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            WassetDropDownFormField(
              hint: '10 سنوات',
              title: 'عمر العقار',
              items: const [
                '0',
                '1 سنة',
                '10 سنوات',
                '20 سنة',
                '30 سنة',
                '40 سنة',
                '50 سنة',
                '60 سنة',
                '70 سنة',
                '80 سنة',
                '90 سنة',
                '100 سنة',
              ],
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        propertyAge: int.tryParse(value!.split(' ')[0]),
                      ),
                    );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'واجهة العقار',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 14,
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  WassetRadioButton(
                    value: 'east',
                    groupValue: state.addAdRequest.facade,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              facade: value,
                            ),
                          );
                    },
                    title: 'شرق',
                  ),
                  WassetRadioButton(
                    value: 'north',
                    groupValue: state.addAdRequest.facade,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              facade: value,
                            ),
                          );
                    },
                    title: 'شمال',
                  ),
                  WassetRadioButton(
                    value: 'south',
                    groupValue: state.addAdRequest.facade,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              facade: value,
                            ),
                          );
                    },
                    title: 'جنوب',
                  ),
                  WassetRadioButton(
                    value: 'west',
                    groupValue: state.addAdRequest.facade,
                    onChanged: (value) {
                      context.read<AddNewAdCubit>().changeAdRequest(
                            state.addAdRequest.copyWith(
                              facade: value,
                            ),
                          );
                    },
                    title: 'غرب',
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
