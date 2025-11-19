import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/features/user/presentation/notifications/cubit/notifications_cubit.dart';
import 'package:waseet/features/user/presentation/notifications/widgets/loaded_notifications_item.dart';

class LoadedNotifications extends StatelessWidget {
  const LoadedNotifications({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10).r,
            child: Column(
              children: List.generate(
                state.notifications.length,
                (index) => LoadedNotificationsItem(
                  notification: state.notifications[index],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
