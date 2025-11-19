import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/features/user/presentation/login/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/login/widgets/login_body.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/router/screens.dart';

/// {@template login_page}
/// A description for LoginPage
/// {@endtemplate}
class LoginPage extends StatelessWidget {
  /// {@macro login_page}
  const LoginPage({super.key});

  /// The static route for LoginPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: LoginView(),
      ),
    );
  }
}

/// {@template login_view}
/// Displays the Body of LoginView
/// {@endtemplate}
class LoginView extends StatelessWidget {
  /// {@macro login_view}
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          HelperMethod.showSnackBar(
            context,
            state.errorMessage.isNotEmpty ? state.errorMessage : 'حدث خطأ ما',
            type: SnackBarType.error,
          );
        }

        if (state.status.isInProgress) {
          HelperMethod.showSnackBar(context, 'جاري تسجيل الدخول');
        }

        if (state.status.isSuccess) {
          context.read<AppBloc>().add(AppStarted());
          context.goNamed(Screens.home.name);
        }
      },
      child: const LoginBody(),
    );
  }
}
