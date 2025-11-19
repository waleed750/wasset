import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/brokers/presentation/kingdom_broker/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/packages/cubit/package_controller.dart';
import 'package:waseet/features/user/presentation/packages/cubit/packages_cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/router/screens.dart';

class CardDetailsForm extends StatefulWidget {
  const CardDetailsForm({
    super.key,
  });

  @override
  State<CardDetailsForm> createState() => _CardDetailsFormState();
}

class _CardDetailsFormState extends State<CardDetailsForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cardController = TextEditingController();
  final TextEditingController _cvcController = TextEditingController();
  String year = '2025';
  String month = '01';
  final PackageController _packageController = PackageController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: 20.h,
          ),
          WassetTextField(
            controller: _nameController,
            title: 'الاسم بالبطاقة',
          ),
          SizedBox(
            height: 10.h,
          ),
          WassetTextField(
            controller: _cardController,
            title: 'معلومات البطاقة ',
            hintText: 'رقم البطاقة',
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                // year and month dropdown
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: DropdownButton<String>(
                        value: year,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            year = newValue!;
                          });
                        },
                        items: <String>[
                          ...List.generate(
                            10,
                            (index) => (2025 + index).toString(),
                          ),
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(
                      width: 20.w,
                    ),
                    Expanded(
                      child: DropdownButton<String>(
                        value: month,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            month = newValue!;
                          });
                        },
                        items: <String>[
                          '01',
                          '02',
                          '03',
                          '04',
                          '05',
                          '06',
                          '07',
                          '08',
                          '09',
                          '10',
                          '11',
                          '12',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 20.w,
              ),
              Expanded(
                child: WassetTextField(
                  controller: _cvcController,
                  hintText: 'CVC',
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 5).r,
                    child: SvgPicture.asset(
                      Constants.carsIcon,
                      width: 1,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Expanded(child: SizedBox()),
          SizedBox(
            width: double.infinity,
            child: WassetButton(
              text: 'التالي',
              onTap: () async {
                final paymentLink =
                    await context.read<PackagesCubit>().getPaymentLink(
                          _nameController.text,
                          _cardController.text,
                          year,
                          month,
                          _cvcController.text,
                          context.read<AppBloc>().state.user!.phone!.replaceAll(
                                '+966',
                                ' 0',
                              ),
                        );

                if (paymentLink.isNotEmpty) {
                  final result =
                      await PackageController.pay(paymentLink, context);
                  if (result) {
                    HelperMethod.showSnackBar(
                      context,
                      'تم الدفع بنجاح',
                      type: SnackBarType.success,
                    );
                    context.pushReplacementNamed(Screens.account.name);
                  } else {
                    HelperMethod.showSnackBar(
                      context,
                      'حدث خطأ ما',
                      type: SnackBarType.error,
                    );
                  }
                } else {
                  HelperMethod.showSnackBar(
                    context,
                    context.read<PackagesCubit>().state.message ?? 'حدث خطأ ما',
                    type: SnackBarType.error,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
