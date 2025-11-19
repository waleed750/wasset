import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:waseet/constants/constants.dart';
import 'package:waseet/features/user/presentation/splash/cubit/cubit.dart';

/// {@template splash_body}
/// Body of the SplashPage.
///
/// Add what it does
/// {@endtemplate}
class SplashBody extends StatelessWidget {
  /// {@macro splash_body}
  const SplashBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SplashCubit, SplashState>(
      builder: (context, state) {
        return Center(
          child: SvgPicture.asset(
            Constants.logoWhite,
            width: MediaQuery.sizeOf(context).width * 2 / 3,
          ),
        );
      },
    );
  }
}
