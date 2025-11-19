// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:waseet/features/user/domain/entities/subscription/my_subscription_entity.dart';

class MySubscriptionModel {
  final int? id;
  final String? name;
  final String? description;
  final String? price;
  final String? duration;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? startAt;
  final String? endAt;

  MySubscriptionModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.duration,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.startAt,
    this.endAt,
  });

  factory MySubscriptionModel.fromJson(Map<String, dynamic> json) {
    return MySubscriptionModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      price: json['price'] as String?,
      duration: json['duration'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      startAt: json['subscribed_at'] as String?,
      endAt: json['subscription_end_at'] as String?,
    );
  }

  MySubscriptionEntity toEntity() {
    return MySubscriptionEntity(
      id: id?.toString(),
      name: name,
      description: description,
      price: price,
      duration: duration,
      status: status,
      createdAt: createdAt,
      updatedAt: updatedAt,
      startAt: startAt,
      endAt: endAt,
    );
  }
}
