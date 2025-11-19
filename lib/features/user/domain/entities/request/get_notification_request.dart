// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class GetNotificationRequest extends Equatable {
  final String id;
  final String type;
  final String title;
  final String body;
  final String readAt;
  const GetNotificationRequest({
    required this.id,
    required this.type,
    required this.title,
    required this.body,
    required this.readAt,
  });

  @override
  List<Object?> get props {
    return [id, type, title, body, readAt];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'body': body,
      'read_at': readAt
    };
  }
}
