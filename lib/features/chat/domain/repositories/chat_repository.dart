import 'package:waseet/features/chat/domain/entities/chat_entity.dart';
import 'package:waseet/features/chat/domain/entities/message_model.dart';
import 'package:waseet/features/chat/domain/entities/request/add_message_request.dart';

abstract class ChatRepository {
  Stream<List<MessageEntity>> getMessages(
    String chatId, {
    bool isTahaluf = false,
  });

  Future<void> sendMessage(AddMessageRequest message, {bool isTahaluf = false});

  Stream<List<ChatEntity>> getChats(int userId, {bool isTahaluf = false});

  Future<List<ChatEntity>> getChatsFromApi(
    int userId, {
    bool isTahaluf = false,
  });
}
