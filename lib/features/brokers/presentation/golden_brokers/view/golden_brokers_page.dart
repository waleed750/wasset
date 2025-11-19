import 'package:flutter/material.dart';
import 'package:waseet/features/brokers/domain/repositories/brokers_repository.dart';
import 'package:waseet/features/brokers/presentation/golden_brokers/cubit/cubit.dart';
import 'package:waseet/features/brokers/presentation/golden_brokers/widgets/golden_brokers_body.dart';

/// {@template golden_brokers_page}
/// A description for GoldenBrokersPage
/// {@endtemplate}
class GoldenBrokersPage extends StatelessWidget {
  /// {@macro golden_brokers_page}
  const GoldenBrokersPage({super.key});

  /// The static route for GoldenBrokersPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
        builder: (_) => const GoldenBrokersPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GoldenBrokersCubit(repository: context.read<BrokerRepository>()),
      child: const Scaffold(
        body: GoldenBrokersView(),
      ),
    );
  }
}

/// {@template golden_brokers_view}
/// Displays the Body of GoldenBrokersView
/// {@endtemplate}
class GoldenBrokersView extends StatelessWidget {
  /// {@macro golden_brokers_view}
  const GoldenBrokersView({super.key});

  @override
  Widget build(BuildContext context) {
    return const GoldenBrokersBody();
  }
}
