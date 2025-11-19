import 'package:flutter/material.dart';
import 'package:waseet/features/user/domain/repositories/home_repository.dart';
import 'package:waseet/features/user/presentation/notifications/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/notifications/widgets/notifications_body.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<dynamic>(
      builder: (_) => const NotificationsPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationsCubit(
        homeRepository: context.read<HomeRepository>(),
      ),
      child: const Scaffold(
        body: NotificationsView(),
      ),
    );
  }
}

/// {@template notifications_view}
/// Displays the Body of NotificationsView
/// {@endtemplate}
class NotificationsView extends StatelessWidget {
  /// {@macro notifications_view}
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return const NotificationsBody();
  }
}
