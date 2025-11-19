import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/common_widgets/wasset_text_field.dart';
import 'package:waseet/features/user/presentation/login/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/wasset_button.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

/// {@template login_body}
/// Body of the LoginPage.
///
/// Add what it does
/// {@endtemplate}
class LoginBody extends StatelessWidget {
  /// {@macro login_body}
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(
            'assets/images/city_draw.png',
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            height: 100,
          ),
          const Text(
            'تسجيل دخول',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextButton(
            onPressed: () {
              context.pushNamed(Screens.register.name);
            },
            child: const Text(
              'ليس لديك حساب؟ سجل الان',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 32,
              vertical: 10,
            ),
            child: Column(
              children: [
                BlocBuilder<LoginCubit, LoginState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email,
                  builder: (context, state) {
                    return WassetTextField(
                      title: 'البريد الالكتروني',
                      keyboardType: TextInputType.emailAddress,
                      // errorText: state.email.errorMessage,
                      onChanged: (value) {
                        context.read<LoginCubit>().emailChanged(value);
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 12,
                ),
                BlocBuilder<LoginCubit, LoginState>(
                  builder: (context, state) {
                    return WassetTextField(
                      title: 'كلمة المرور',
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        context.read<LoginCubit>().passwordChanged(value);
                      },
                      isPassword: true,
                      value: state.password,
                    );
                  },
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status,
                    builder: (context, state) {
                      return TextButton(
                        onPressed: () {
                          context.read<LoginCubit>().login();
                        },
                        child: const Text(
                          'نسيت كلمة المرور؟',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<LoginCubit, LoginState>(
                    buildWhen: (previous, current) =>
                        previous.status != current.status ||
                        previous.isFormValid != current.isFormValid,
                    builder: (context, state) {
                      return WassetButton(
                        text: 'تسجيل الدخول',
                        onTap: state.status.isInProgress || !state.isFormValid
                            ? null
                            : () {
                                context.read<LoginCubit>().login();
                              },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
