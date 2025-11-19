import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:waseet/common_widgets/custom_appbar.dart';
import 'package:waseet/common_widgets/error.dart';
import 'package:waseet/common_widgets/skeleton.dart';
import 'package:waseet/features/user/presentation/notifications/cubit/cubit.dart';
import 'package:waseet/features/user/presentation/notifications/widgets/loaded_notifications.dart';
import 'package:waseet/features/user/presentation/notifications/widgets/no_notifications.dart';

/// {@template notifications_body}
/// Body of the NotificationsPage.
///
/// Add what it does
/// {@endtemplate}
class NotificationsBody extends StatelessWidget {
  /// {@macro notifications_body}
  const NotificationsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            children: [
              const CustomAppbar(
                title: 'الإشعارات',
              ),
              SizedBox(
                height: 15.h,
              ),
              if (state.status == NotificationStatus.loading)
                Column(
                  children: [
                    Skeleton(
                      height: 120.h,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Skeleton(
                      height: 120.h,
                    ),
                  ],
                ),
              if (state.status == NotificationStatus.error)
                ErrorPage(
                  onTap: () {
                    context.read<NotificationsCubit>().init();
                  },
                ),
              if (state.status == NotificationStatus.loaded &&
                  state.notifications.isEmpty)
                const NoNotifications(),
              const LoadedNotifications(),
            ],
          ),
        );
      },
    );
  }
}
