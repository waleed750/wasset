import 'package:flutter/material.dart';
import 'package:waseet/app/bloc/app_bloc.dart';
import 'package:waseet/features/user/presentation/home_page/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/home_page/widgets/main_page.dart';

/// {@template home_page_body}
/// Body of the HomePagePage.
///
/// Add what it does
/// {@endtemplate}
class HomePageBody extends StatelessWidget {
  /// {@macro home_page_body}
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AppBloc, AppState>(
        builder: (context, state) {
          final isAuthenticated = state.status;
          final isWasset = state.isWasset;
          return MainPage(
            isWasset: isWasset,
            isAuthenticated: isAuthenticated,
          );
        },
      ),
    );
  }
}

// Row(
//   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//   children: [
//     IconButton(
//       onPressed: () {
//         context.goNamed(Screens.login.name);
// context.read<AppBloc>().add(AppLoggedOut());
//       },
//       icon: const Text('login'),
//     ),
//     IconButton(
//       onPressed: () {
//         context.goNamed(Screens.register.name);
//       },
//       icon: const Text('register'),
//     ),
