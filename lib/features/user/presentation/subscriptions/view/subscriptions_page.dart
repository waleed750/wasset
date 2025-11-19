import 'package:flutter/material.dart';
import 'package:waseet/common_widgets/wasset_app_bar.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';
import 'package:waseet/features/user/presentation/subscriptions/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/subscriptions/widgets/subscriptions_body.dart';

/// {@template subscriptions_page}
/// A description for SubscriptionsPage
/// {@endtemplate}
class SubscriptionsPage extends StatelessWidget {
  /// {@macro subscriptions_page}
  const SubscriptionsPage({super.key});

  /// The static route for SubscriptionsPage
  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const SubscriptionsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SubscriptionsCubit(
        repository: context.read<AuthenticationRepository>(),
      ),
      child: const Scaffold(
        appBar: WassetAppBar(title: 'الاشتراكات'),
        body: SubscriptionsView(),
      ),
    );
  }
}

/// {@template subscriptions_view}
/// Displays the Body of SubscriptionsView
/// {@endtemplate}
class SubscriptionsView extends StatelessWidget {
  /// {@macro subscriptions_view}
  const SubscriptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SubscriptionsBody();
  }
}
