import 'package:waseet/features/chat/data/models/chat_model.dart';
import 'package:waseet/features/chat/data/models/message_model.dart';
import 'package:waseet/features/chat/domain/entities/chat_entity.dart';
import 'package:waseet/features/chat/domain/entities/message_model.dart';

class ChatAndDetailsEntity {
  ChatAndDetailsEntity({
    this.message,
    required this.chat,
  });

  factory ChatAndDetailsEntity.fromMap(Map<String, dynamic> map) {
    return ChatAndDetailsEntity(
      message: map['message'] != null &&
              map['message'] is List &&
              (map['message'] as List).isNotEmpty
          ? List<MessageEntity>.from(
              (map['message'] as List).map(
                (x) =>
                    MessageModel.fromJson(x as Map<String, dynamic>).toEntity(),
              ),
            )
          : null,
      chat: ChatModel.fromMap(map['chat'] as Map<String, dynamic>).toEntity(),
    );
  }

  final List<MessageEntity>? message;
  final ChatEntity chat;
}
