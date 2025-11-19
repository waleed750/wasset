import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:waseet/features/chat/data/datasources/chat_datasource.dart';
import 'package:waseet/features/chat/data/models/chat_model.dart';
import 'package:waseet/features/chat/data/models/message_model.dart';
import 'package:waseet/features/chat/domain/entities/chat_entity.dart';
import 'package:waseet/features/chat/domain/entities/message_model.dart';
import 'package:waseet/features/chat/domain/entities/request/add_message_request.dart';
import 'package:waseet/res/api_service.dart';

class ChatDataSoruceImpl extends ChatDataSource {
  ChatDataSoruceImpl({
    FirebaseFirestore? firestore,
    FirebaseStorage? firebaseStorage,
    required ApiService apiServices,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance,
        _apiServices = apiServices;

  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;
  final ApiService _apiServices;

  @override
  Stream<List<ChatEntity>> getChats(int userId, {bool isTahaluf = false}) {
    final chatKey = isTahaluf ? 'chat_rooms' : 'chats';
    return _firestore
        .collection(chatKey)
        .where(
          'users',
          arrayContains: userId,
        )
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) =>
                    ChatModel.fromMap(e.data()).copyWith(id: e.id).toEntity(),
              )
              .toList(),
        );
  }

  @override
  Stream<List<MessageEntity>> getMessages(
    String chatId, {
    bool isTahaluf = false,
  }) {
    final chatKey = isTahaluf ? 'chat_rooms' : 'chats';
    return _firestore
        .collection(chatKey)
        .doc(chatId)
        .collection('messages')
        // .orderBy('sended_at')
        .snapshots()
        .map(
          (event) => event.docs
              .map((e) => MessageModel.fromJson(e.data()).toEntity())
              .toList(),
        );
  }

  @override
  Future<void> sendMessage(
    AddMessageRequest message, {
    bool isTahaluf = false,
  }) async {
    String? fileUrl;
    if (message.type == 'image' ||
        message.type == 'video' ||
        message.type == 'audio' ||
        message.type == 'file') {
      final ref =
          _firebaseStorage.ref().child('chat_files').child(message.filePath!);
      final uploadTask = ref.putFile(File(message.filePath!));
      final snapshot = await uploadTask.whenComplete(() => null);
      fileUrl = await snapshot.ref.getDownloadURL();
    }

    final result = await _apiServices.post(
      isTahaluf
          ? 'alliances/chat_rooms/${message.chatId}/messages'
          : 'chats/${message.chatId}/messages',
      data: message.toJson(),
    );
  }

  @override
  Future<List<ChatEntity>> getChatsFromApi(
    int userId, {
    bool isTahaluf = false,
  }) async {
    // final chatKey = isTahaluf ? 'chat_rooms' : 'chats';
    final response = await _apiServices.get<Map<String, dynamic>>(
      'chats',
    );
    if (response != null) {
      return (response['data'] as List)
          .map((e) => ChatModel.fromMap(e as Map<String, dynamic>).toEntity())
          .toList();
    }
    return [];
  }
}
