import 'dart:convert';

import 'package:waseet/features/user/domain/entities/notification_entity.dart';

class NotificationModel {
  NotificationModel(
      {this.id, this.type, this.title, this.body, this.readAt, this.createdAt});

  factory NotificationModel.fromMap(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'] as String?,
        type: json['type'] as String?,
        title: json['title'] as String?,
        body: json['body'] as String?,
        readAt: json['read_at'] as String?,
        createdAt: json['created_at'] as String?,
      );
  factory NotificationModel.fromJson(String data) {
    return NotificationModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  String? id;
  String? type;
  String? title;
  String? body;
  String? readAt;
  String? createdAt;

  Map<String, dynamic> toMap() => {
        'id': id,
        'type': type,
        'title': title,
        'body': body,
        'read_at': readAt,
        'created_at': createdAt,
      };
  String toJson() => json.encode(toMap());

  NotificationEntity toEntity() {
    return NotificationEntity(
        id: id,
        type: type,
        title: title,
        body: body,
        readAt: readAt,
        createdAt: createdAt);
  }
}
