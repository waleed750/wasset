import 'package:flutter/material.dart';
import 'package:waseet/features/user/presentation/register/widgets/register_form.dart';
import 'package:waseet/res/res.dart';

/// {@template register_body}
/// Body of the RegisterPage.
///
/// Add what it does
/// {@endtemplate}
class RegisterBody extends StatelessWidget {
  /// {@macro register_body}
  const RegisterBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SingleChildScrollView(
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
              'انشاء حساب كوسيط',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const RegisterForm(),
          ],
        ),
      ),
    );
  }
}
