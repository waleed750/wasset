import 'package:waseet/features/chat/data/datasources/chat_datasource.dart';
import 'package:waseet/features/chat/domain/entities/chat_entity.dart';
import 'package:waseet/features/chat/domain/entities/message_model.dart';
import 'package:waseet/features/chat/domain/entities/request/add_message_request.dart';
import 'package:waseet/features/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl extends ChatRepository {
  ChatRepositoryImpl({required this.chatDataSource});
  final ChatDataSource chatDataSource;

  @override
  Stream<List<ChatEntity>> getChats(int userId, {bool isTahaluf = false}) {
    return chatDataSource.getChats(userId, isTahaluf: isTahaluf);
  }

  @override
  Stream<List<MessageEntity>> getMessages(
    String chatId, {
    bool isTahaluf = false,
  }) {
    return chatDataSource.getMessages(chatId, isTahaluf: isTahaluf);
  }

  @override
  Future<void> sendMessage(
    AddMessageRequest message, {
    bool isTahaluf = false,
  }) {
    return chatDataSource.sendMessage(message, isTahaluf: isTahaluf);
  }

  @override
  Future<List<ChatEntity>> getChatsFromApi(int userId,
      {bool isTahaluf = false}) async {
    return chatDataSource.getChatsFromApi(userId, isTahaluf: isTahaluf);
  }
}
