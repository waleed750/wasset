import 'package:waseet/features/user/data/models/subscription_model/payment_model.dart';
import 'package:waseet/features/user/domain/entities/subscription/subscription_entity.dart';

class SubscriptionModel {
  SubscriptionModel({
    this.id,
    this.userId,
    this.packageId,
    this.status,
    this.subscribedAt,
    this.subscriptionEndAt,
    this.payment,
  });

  factory SubscriptionModel.fromJson(Map<String, dynamic> json) {
    return SubscriptionModel(
      id: json['id'] as int?,
      userId: json['user_id'] as int?,
      packageId: json['package_id'] as int?,
      status: json['status'] as dynamic,
      subscribedAt: json['subscribed_at'] == null
          ? null
          : DateTime.parse(json['subscribed_at'] as String),
      subscriptionEndAt: json['subscription_end_at'] == null
          ? null
          : DateTime.parse(json['subscription_end_at'] as String),
      payment: json['payment'] == null
          ? null
          : PaymentModel.fromJson(json['payment'] as Map<String, dynamic>),
    );
  }
  int? id;
  int? userId;
  int? packageId;
  dynamic status;
  DateTime? subscribedAt;
  DateTime? subscriptionEndAt;
  PaymentModel? payment;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'package_id': packageId,
        'status': status,
        'subscribed_at': subscribedAt?.toIso8601String(),
        'subscription_end_at': subscriptionEndAt?.toIso8601String(),
        'payment': payment?.toJson(),
      };

  SubscriptionEntity toEntity() {
    return SubscriptionEntity(
      id: id,
      userId: userId,
      packageId: packageId,
      status: status,
      subscribedAt: subscribedAt,
      subscriptionEndAt: subscriptionEndAt,
      payment: payment?.toEntity(),
    );
  }
}
