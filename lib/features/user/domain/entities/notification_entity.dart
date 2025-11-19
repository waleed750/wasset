import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  const NotificationEntity({
    this.id,
    this.type,
    this.title,
    this.body,
    this.readAt,
    this.createdAt,
  });

  final String? id;
  final String? type;
  final String? title;
  final String? body;
  final String? readAt;
  final String? createdAt;

  @override
  List<Object?> get props => [id, type, title, body, readAt, createdAt];
}
