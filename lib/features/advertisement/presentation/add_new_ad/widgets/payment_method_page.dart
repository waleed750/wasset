// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_radio_button.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/profile_text_field.dart';
import 'package:waseet/res/res.dart';

class PaymentMethodPage extends StatelessWidget {
  const PaymentMethodPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAdCubit, AddNewAdState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            ProfileTextField(
              text: 'السعر',
              keyboardType: TextInputType.number,
              initialValue: state.addAdRequest.price.toString(),
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        price: int.tryParse(value),
                      ),
                    );
              },
            ),
            const SizedBox(height: 20),
            SwitchListTile.adaptive(
              contentPadding: EdgeInsets.zero,
              title: const Text(
                'قابل للتفاوض',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              value: state.addAdRequest.negotiable,
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        negotiable: value,
                      ),
                    );
              },
              activeColor: AppColors.primaryColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
            const SizedBox(height: 20),
            const Text(
              'طريقة الدفع',
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
                  color: const Color(0xFFC4C4C4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    WassetRadioButton(
                      title: 'كاش',
                      value: 'cash',
                      groupValue: state.addAdRequest.paymentMethod,
                      onChanged: (value) {
                        context.read<AddNewAdCubit>().changeAdRequest(
                              state.addAdRequest.copyWith(
                                paymentMethod: value,
                              ),
                            );
                      },
                    ),
                    WassetRadioButton(
                      title: 'تمويل',
                      value: 'financing',
                      groupValue: state.addAdRequest.paymentMethod,
                      onChanged: (value) {
                        context.read<AddNewAdCubit>().changeAdRequest(
                              state.addAdRequest.copyWith(
                                paymentMethod: value,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'كيف تفضل طريقة التواصل',
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
                  color: const Color(0xFFC4C4C4),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    WassetRadioButton(
                      title: 'محادثة',
                      value: 'chat',
                      groupValue: state.addAdRequest.communicationMethod,
                      onChanged: (value) {
                        context.read<AddNewAdCubit>().changeAdRequest(
                              state.addAdRequest.copyWith(
                                communicationMethod: value,
                              ),
                            );
                      },
                    ),
                    WassetRadioButton(
                      title: 'واتساب',
                      value: 'whatsapp',
                      groupValue: state.addAdRequest.communicationMethod,
                      onChanged: (value) {
                        context.read<AddNewAdCubit>().changeAdRequest(
                              state.addAdRequest.copyWith(
                                communicationMethod: value,
                              ),
                            );
                      },
                    ),
                    WassetRadioButton(
                      title: 'اتصال',
                      value: 'call',
                      groupValue: state.addAdRequest.communicationMethod,
                      onChanged: (value) {
                        context.read<AddNewAdCubit>().changeAdRequest(
                              state.addAdRequest.copyWith(
                                communicationMethod: value,
                              ),
                            );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ProfileTextField(
              text: 'تفاصيل اضافية ',
              hintText: 'اذكر المزايا والعيوب وأي تفاصيل أخرى تهم العميل',
              maxLines: 3,
              initialValue: state.addAdRequest.extraInfo,
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        extraInfo: value,
                      ),
                    );
              },
            ),
            const SizedBox(height: 20),
          ],
        );
      },
    );
  }
}
