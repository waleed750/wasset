import 'package:flutter/material.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/advertisement/domain/repositories/ad_repository.dart';
import 'package:waseet/features/brokers/presentation/my_personal_office/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/my_personal_office/widgets/my_personal_office_body.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';

/// {@template my_personal_office_page}
/// A description for MyPersonalOfficePage
/// {@endtemplate}
class MyPersonalOfficePage extends StatelessWidget {
  /// {@macro my_personal_office_page}
  const MyPersonalOfficePage({super.key, this.userId});

  /// The static route for MyPersonalOfficePage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const MyPersonalOfficePage(),
    );
  }

  final int? userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyPersonalOfficeCubit(
        adRepository: context.read<AdRepository>(),
        userId: userId ?? context.read<AppBloc>().state.user!.id,
        isUserProfile:
            userId == context.read<AppBloc>().state.user?.id || userId == null,
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const Scaffold(
        body: MyPersonalOfficeView(),
      ),
    );
  }
}

/// {@template my_personal_office_view}
/// Displays the Body of MyPersonalOfficeView
/// {@endtemplate}
class MyPersonalOfficeView extends StatelessWidget {
  /// {@macro my_personal_office_view}
  const MyPersonalOfficeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyPersonalOfficeBody();
  }
}
