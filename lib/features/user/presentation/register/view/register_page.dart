import 'package:flutter/material.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/features/user/presentation/register/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/register/widgets/register_body.dart';
import 'package:waseet/res/helper_method.dart';
import 'package:waseet/router/screens.dart';

/// {@template register_page}
/// A description for RegisterPage
/// {@endtemplate}
class RegisterPage extends StatelessWidget {
  /// {@macro register_page}
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        authenticationRepository: context.read<AuthenticationRepository>(),
      ),
      child: const Scaffold(
        body: RegisterView(),
      ),
    );
  }
}

/// {@template register_view}
/// Displays the Body of RegisterView
/// {@endtemplate}
class RegisterView extends StatelessWidget {
  /// {@macro register_view}
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          HelperMethod.showSnackBar(context, 'تم التسجيل بنجاح');
          context.goNamed(Screens.home.name);
        }

        if (state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage.isNotEmpty
                      ? state.errorMessage
                      : 'حدث خطأ ما',
                ),
                backgroundColor: Colors.red,
              ),
            );
        }

        if (state.status.isInProgress) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              const SnackBar(
                content: Text('جاري التسجيل'),
              ),
            );
        }
      },
      child: const SafeArea(child: RegisterBody()),
    );
  }
}
