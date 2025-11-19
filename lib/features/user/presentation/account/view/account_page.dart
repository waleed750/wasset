import 'package:flutter/material.dart';
import 'package:waseet/features/user/presentation/account/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/account/widgets/account_body.dart';

/// {@template account_page}
/// A description for AccountPage
/// {@endtemplate}
class AccountPage extends StatelessWidget {
  /// {@macro account_page}
  const AccountPage({super.key});

  /// The static route for AccountPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const AccountPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountCubit(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('حسابي'),
        ),
        body: const AccountView(),
      ),
    );
  }
}

/// {@template account_view}
/// Displays the Body of AccountView
/// {@endtemplate}
class AccountView extends StatelessWidget {
  /// {@macro account_view}
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AccountCubit, AccountState>(
      listener: (context, state) {
        if (state.status == AccountStatus.error) {
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
      },
      child: const AccountBody(),
    );
  }
}
