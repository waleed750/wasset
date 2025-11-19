import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/features/user/presentation/splash/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/splash/widgets/splash_body.dart';
import 'package:waseet/res/res.dart';
import 'package:waseet/router/screens.dart';

/// {@template splash_page}
/// A description for SplashPage
/// {@endtemplate}
class SplashPage extends StatelessWidget {
  /// {@macro splash_page}
  const SplashPage({super.key});

  /// The static route for SplashPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const SplashPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashCubit(),
      child: const Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SplashView(),
      ),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.moving) {
          context.goNamed(Screens.home.name);
        }
      },
      child: const SplashBody(),
    );
  }
}
