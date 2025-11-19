import 'package:flutter/material.dart';
import 'package:waseet/features/user/presentation/packages/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/packages/widgets/packages_body.dart';

/// {@template packages_page}
/// A description for PackagesPage
/// {@endtemplate}
class PackagesPage extends StatelessWidget {
  /// {@macro packages_page}
  const PackagesPage({super.key});

  /// The static route for PackagesPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(builder: (_) => const PackagesPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PackagesCubit(
        homeRepository: context.read(),
        authenticationRepository: context.read(),
      ),
      child: const Scaffold(
        body: PackagesView(),
      ),
    );
  }
}

/// {@template packages_view}
/// Displays the Body of PackagesView
/// {@endtemplate}
class PackagesView extends StatelessWidget {
  /// {@macro packages_view}
  const PackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PackagesBody();
  }
}
