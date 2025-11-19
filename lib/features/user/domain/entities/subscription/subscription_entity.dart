import 'package:waseet/features/user/domain/entities/subscription/payment_entity.dart';

class SubscriptionEntity {
  SubscriptionEntity({
    this.id,
    this.userId,
    this.packageId,
    this.status,
    this.subscribedAt,
    this.subscriptionEndAt,
    this.payment,
  });
  int? id;
  int? userId;
  int? packageId;
  dynamic status;
  DateTime? subscribedAt;
  DateTime? subscriptionEndAt;
  PaymentEntity? payment;
}
