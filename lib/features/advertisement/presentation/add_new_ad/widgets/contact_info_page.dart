// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/profile_text_field.dart';

class ContactInfoPage extends StatelessWidget {
  const ContactInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAdCubit, AddNewAdState>(
      builder: (context, state) {
        return Column(
          children: [
            const SizedBox(height: 20),
            ProfileTextField(
              text: 'اسم المعلن',
              keyboardType: TextInputType.name,
              initialValue: state.addAdRequest.advertiserName,
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        advertiserName: value,
                      ),
                    );
              },
            ),
            const SizedBox(height: 20),
            ProfileTextField(
              text: 'رقم التواصل',
              keyboardType: TextInputType.number,
              initialValue: state.addAdRequest.contactPhone,
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        contactPhone: value,
                      ),
                    );
              },
            ),
            const SizedBox(height: 20),
            ProfileTextField(
              text: 'رقم ترخيص الاعلان',
              keyboardType: TextInputType.number,
              initialValue:
                  state.addAdRequest.advertisingLicenseNumber.toString(),
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        advertisingLicenseNumber: int.tryParse(value),
                      ),
                    );
              },
            ),
            const SizedBox(height: 20),
            const Text(
              'أقر وأتعهد على شروط وسياسات استخدام المنصة والضوابط الصادرة من الهيئة العامة للعقار وأتحمل مايخالف ذلك',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        );
      },
    );
  }
}
