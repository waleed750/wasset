part of 'notifications_cubit.dart';

enum NotificationStatus { initial, loading, loaded, error }

@immutable
class NotificationsState extends Equatable {
  const NotificationsState({
    this.notifications = const [],
    this.errorMessage = '',
    this.status = NotificationStatus.initial,
  });

  final String errorMessage;
  final List<NotificationEntity> notifications;
  final NotificationStatus status;

  @override
  List<Object> get props => [errorMessage, notifications, status];

  NotificationsState copyWith({
    String? errorMessage,
    List<NotificationEntity>? notifications,
    NotificationStatus? status,
  }) {
    return NotificationsState(
      errorMessage: errorMessage ?? this.errorMessage,
      notifications: notifications ?? this.notifications,
      status: status ?? this.status,
    );
  }
}

class NotificationsInitial extends NotificationsState {
  const NotificationsInitial() : super();
}
