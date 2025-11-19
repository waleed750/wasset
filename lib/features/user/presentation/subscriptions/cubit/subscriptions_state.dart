part of 'subscriptions_cubit.dart';

enum SubscriptionsStatus { initial, loading, loaded, error }

class SubscriptionsState extends Equatable {
  const SubscriptionsState({
    this.subscriptions = const <MySubscriptionEntity>[],
    this.status = SubscriptionsStatus.initial,
    this.error,
  });

  final List<MySubscriptionEntity> subscriptions;
  final SubscriptionsStatus status;
  final String? error;

  SubscriptionsState copyWith({
    List<MySubscriptionEntity>? subscriptions,
    SubscriptionsStatus? status,
    String? error,
  }) {
    return SubscriptionsState(
      subscriptions: subscriptions ?? this.subscriptions,
      status: status ?? this.status,
      error: error,
    );
  }

  @override
  List<Object?> get props => [subscriptions, status, error];
}
