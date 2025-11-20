import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:moyasar/moyasar.dart';
import 'package:waseet/common_widgets/custom_appbar.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/presentation/packages/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/assets/assets.gen.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

class PaymentBody extends StatelessWidget {
  PaymentBody({super.key});

  final paymentConfig = PaymentConfig(
    publishableApiKey: 'YOUR_API_KEY',
    amount: 25758, // SAR 257.58
    description: 'order #1324',
    metadata: {'size': '250g'},
    applePay: ApplePayConfig(
      saveCard: false,
      merchantId: 'YOUR_MERCHANT_ID',
      label: 'YOUR_STORE_NAME',
      manual: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PackagesCubit, PackagesState>(
      builder: (context, state) {
        var groupValue = 'mada';
        return SafeArea(
          child: StatefulBuilder(
            builder: (
              BuildContext context,
              void Function(void Function()) setState,
            ) {
              return Column(
                children: [
                  const CustomAppbar(title: 'الدفع'),
                  PaymentMethodCard(
                    radio: Radio(
                      activeColor: AppColors.primaryColor,
                      value: 'mada',
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    text: 'بطاقة بنكية ',
                    image: Assets.images.paymentMada.path,
                  ),
                  PaymentMethodCard(
                    radio: Radio(
                      activeColor: AppColors.primaryColor,
                      value: 'visa',
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    text: 'بطاقة ائتمانية ',
                    image: Constants.visa,
                  ),
                  PaymentMethodCard(
                    radio: Radio(
                      activeColor: AppColors.primaryColor,
                      value: 'apple',
                      groupValue: groupValue,
                      onChanged: (value) {
                        setState(() {
                          groupValue = value!;
                        });
                      },
                    ),
                    text: 'ApplePay',
                    image: Constants.apple,
                  ),
                  // ApplePay(
                  //   config: paymentConfig,
                  //   onPaymentResult: () {},
                  // ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: SizedBox(
                      width: double.infinity,
                      child: WassetButton(
                        text: 'التالي',
                        onTap: () {
                          if (groupValue == 'mada') {
                            context.pushNamed(
                              Screens.cardDetails.name,
                              extra: context.read<PackagesCubit>(),
                            );
                          } else if (groupValue == 'visa') {
                            context.pushNamed(
                              Screens.cardDetails.name,
                              extra: context.read<PackagesCubit>(),
                            );
                          } else if (groupValue == 'apple') {}
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}

class PaymentMethodCard extends StatelessWidget {
  const PaymentMethodCard({
    super.key,
    required this.text,
    required this.image,
    required this.radio,
  });
  final String text;
  final String image;
  final Widget radio;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15).r,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20).r,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(101, 115, 50, 255),
            blurRadius: 4,
            offset: Offset(0, 1.68),
          ),
        ],
        borderRadius: BorderRadius.circular(16).r,
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              radio,
              Text(text),
            ],
          ),
          if (image.contains('svg'))
            SvgPicture.asset(image)
          else
            Image.asset(image),
        ],
      ),
    );
  }
}
