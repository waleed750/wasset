import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/custom_appbar.dart';
import 'package:waseet/features/user/presentation/packages/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/packages/widgets/card_details_form.dart';

class CardDetailsBody extends StatelessWidget {
  const CardDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackagesCubit, PackagesState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              const CustomAppbar(title: 'الدفع'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            state.selectedPackage?.duration ?? '',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.selectedPackage?.price ?? '',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const Expanded(child: CardDetailsForm()),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
