// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:waseet/features/advertisement/presentation/add_new_ad/add_new_ad.dart';
import 'package:waseet/features/user/presentation/profile_info/widgets/profile_text_field.dart';
import 'package:waseet/res/res.dart';

class GurntessPage extends StatelessWidget {
  const GurntessPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddNewAdCubit, AddNewAdState>(
      builder: (context, state) {
        return Column(
          children: [
            ProfileTextField(
              text: 'عدد الشوارع',
              initialValue: state.addAdRequest.streetsCount.toString(),
              onChanged: (value) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        streetsCount: int.tryParse(value),
                      ),
                    );
              },
            ),
            const SizedBox(
              height: 10,
            ),
            SwitchListTile.adaptive(
              value: state.addAdRequest.warranties,
              onChanged: (v) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        warranties: v,
                      ),
                    );
              },
              title: const Text('ضمانات'),
              activeColor: AppColors.primaryColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
            SwitchListTile.adaptive(
              value: state.addAdRequest.saudiCode,
              onChanged: (v) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        saudiCode: v,
                      ),
                    );
              },
              title: const Text('الكود السعودي'),
              activeColor: AppColors.primaryColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
            SwitchListTile.adaptive(
              value: state.addAdRequest.electricityMeter,
              onChanged: (v) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        electricityMeter: v,
                      ),
                    );
              },
              title: const Text('عداد الكهرباء'),
              activeColor: AppColors.primaryColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
            SwitchListTile.adaptive(
              value: state.addAdRequest.waterMeter,
              onChanged: (v) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        waterMeter: v,
                      ),
                    );
              },
              title: const Text('عداد المياه'),
              activeColor: AppColors.primaryColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
            SwitchListTile.adaptive(
              value: state.addAdRequest.sewerage,
              onChanged: (v) {
                context.read<AddNewAdCubit>().changeAdRequest(
                      state.addAdRequest.copyWith(
                        sewerage: v,
                      ),
                    );
              },
              title: const Text('صرف صحي'),
              activeColor: AppColors.primaryColor,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey[300],
            ),
          ],
        );
      },
    );
  }
}
