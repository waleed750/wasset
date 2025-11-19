import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/user/presentation/register/cubit/register_cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/features/user/presentation/splash/cubit/cubit.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/res/validators/email_validation_field.dart';
import 'package:waseet/res/validators/name_validation_field.dart';
import 'package:waseet/res/validators/password_validation_field.dart';
import 'package:waseet/res/validators/saudi_phone_number_validation_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 10,
      ),
      child: BlocBuilder<RegisterCubit, RegisterState>(
        builder: (context, regiestState) {
          return Column(
            children: [
              // choose user type
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE5E5E5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: regiestState.type == 'customer'
                              ? AppColors.primaryColor
                              : null,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<RegisterCubit>()
                                .typeChanged('customer');
                          },
                          child: Text(
                            'عميل',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: regiestState.type == 'customer'
                                  ? Colors.white
                                  : const Color(0xFF5E6366),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<RegisterCubit>().typeChanged('wasset');
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: regiestState.type == 'wasset'
                                ? AppColors.primaryColor
                                : null,
                          ),
                          child: Text(
                            'وسيط',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: regiestState.type == 'wasset'
                                  ? Colors.white
                                  : const Color(0xFF5E6366),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              // choose gender
              Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFE5E5E5),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: regiestState.gender == 'male'
                              ? AppColors.primaryColor
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context.read<RegisterCubit>().genderChanged('male');
                          },
                          child: Text(
                            'ذكر',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: regiestState.gender == 'male'
                                  ? Colors.white
                                  : const Color(0xFF5E6366),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: regiestState.gender == 'female'
                              ? AppColors.primaryColor
                              : null,
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            context
                                .read<RegisterCubit>()
                                .genderChanged('female');
                          },
                          child: Text(
                            'أنثى',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: regiestState.gender == 'female'
                                  ? Colors.white
                                  : const Color(0xFF5E6366),
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) => previous.name != current.name,
                builder: (context, state) {
                  return WassetTextField(
                    title: 'الاسم',
                    onChanged: (value) {
                      context.read<RegisterCubit>().nameChanged(value);
                    },
                    errorText: state.name.errorMessage,
                    // value: state.name.value,
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.email != current.email,
                builder: (context, state) {
                  return WassetTextField(
                    title: 'البريد الالكتروني',
                    keyboardType: TextInputType.emailAddress,
                    errorText: state.email.errorMessage,
                    onChanged: (value) {
                      context.read<RegisterCubit>().emailChanged(value);
                    },
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.password != current.password,
                builder: (context, state) {
                  return WassetTextField(
                    title: 'كلمة المرور',
                    errorText: state.password.errorMessage,
                    onChanged: (value) {
                      context.read<RegisterCubit>().passwordChanged(value);
                    },
                    isPassword: true,
                  );
                },
              ),
              const SizedBox(
                height: 12,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.phoneNumber != current.phoneNumber,
                builder: (context, state) {
                  return WassetTextField(
                    title: 'رقم الجوال',
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      context.read<RegisterCubit>().phoneNumberChanged(value);
                    },
                    errorText: state.status.isFailure
                        ? state.phoneNumber.errorMessage
                        : null,
                    hintText: 'XX XXX XXXX',
                    isRtl: false,
                    prefixIcon: SizedBox(
                      // width: 20,
                      // height: 10,
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(
                              width: 7.5,
                            ),
                            const Text(
                              '+966',
                              textDirection: TextDirection.ltr,
                              style: TextStyle(
                                color: Color(0xFF5E6366),
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 7.5,
                            ),
                            const SizedBox(
                              height: 30,
                              child: VerticalDivider(
                                width: 1,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              width: 7.5,
                            ),
                            Image.asset(
                              'assets/images/saudi_arabia_flag.png',
                              width: 30,
                              height: 30,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(
                              width: 7.5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 70,
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.isFormValid != current.isFormValid,
                builder: (context, state) {
                  return SizedBox(
                    width: double.infinity,
                    child: WassetButton(
                      text: 'تسجيل',
                      onTap: state.isFormValid
                          ? () {
                              context.read<RegisterCubit>().register();
                            }
                          : null,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
