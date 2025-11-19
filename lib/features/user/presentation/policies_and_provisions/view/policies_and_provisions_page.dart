import 'package:flutter/material.dart';
import 'package:waseet/features/user/presentation/policies_and_provisions/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/policies_and_provisions/widgets/policies_and_provisions_body.dart';

/// {@template policies_and_provisions_page}
/// A description for PoliciesAndProvisionsPage
/// {@endtemplate}
class PoliciesAndProvisionsPage extends StatelessWidget {
  /// {@macro policies_and_provisions_page}
  const PoliciesAndProvisionsPage({super.key});

  /// The static route for PoliciesAndProvisionsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const PoliciesAndProvisionsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PoliciesAndProvisionsCubit(),
      child: const Scaffold(
        body: PoliciesAndProvisionsView(),
      ),
    );
  }
}

/// {@template policies_and_provisions_view}
/// Displays the Body of PoliciesAndProvisionsView
/// {@endtemplate}
class PoliciesAndProvisionsView extends StatelessWidget {
  /// {@macro policies_and_provisions_view}
  const PoliciesAndProvisionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const PoliciesAndProvisionsBody();
  }
}
