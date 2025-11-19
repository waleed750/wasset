// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:waseet/features/chat/data/models/message_model.dart';
import 'package:waseet/features/chat/domain/entities/chat_entity.dart';
import 'package:waseet/features/user/data/models/wasset_user/wasset_user/wasset_profile_model.dart';

class ChatModel extends Equatable {
  final String? id;
  final WassetProfileModel? user;
  final String? wassetUserId;
  final String? customerUserId;
  final bool? isActive;
  final MessageModel? lastMessage;
  final DateTime? lastMessageDate;
  final String? token;
  final List<int>? users;
  const ChatModel({
    this.id,
    this.user,
    this.wassetUserId,
    this.customerUserId,
    this.isActive,
    this.lastMessage,
    this.lastMessageDate,
    this.token,
    this.users,
  });

  static ChatModel empty() => const ChatModel();

  ChatModel copyWith({
    String? id,
    WassetProfileModel? user,
    String? wassetUserId,
    String? customerUserId,
    bool? isActive,
    MessageModel? lastMessage,
    DateTime? lastMessageDate,
    String? token,
    List<int>? users,
  }) {
    return ChatModel(
      id: id ?? this.id,
      user: user ?? this.user,
      wassetUserId: wassetUserId ?? this.wassetUserId,
      customerUserId: customerUserId ?? this.customerUserId,
      isActive: isActive ?? this.isActive,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageDate: lastMessageDate ?? this.lastMessageDate,
      token: token ?? this.token,
      users: users ?? this.users,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'wasset_user_id': wassetUserId,
      'customer_user_id': customerUserId,
      'is_active': isActive,
      'last_message': lastMessage,
      'last_message_date': lastMessageDate?.millisecondsSinceEpoch,
      // 'token': token,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      id: map['id'] != null ? map['id'] as String : null,
      wassetUserId: map['wasset_user_id'] != null
          ? map['wasset_user_id'] as String
          : null,
      customerUserId: map['customer_user_id'] != null
          ? map['customer_user_id'] as String
          : null,
      isActive: map['is_active'] != null ? map['is_active'] as bool : null,
      lastMessage: map['last_message'] != null
          ? MessageModel.fromJson(map['last_message'] as Map<String, dynamic>)
          : null,
      lastMessageDate: map['sended_at'] != null
          ? map['sended_at'] is String
              ? DateTime.tryParse(map['sended_at'].toString())?.toLocal() ??
                  DateTime.now()
              : DateTime.fromMillisecondsSinceEpoch(map['sended_at'] as int)
                  .toLocal()
          : null,
      users: map['users'] != null ? List<int>.from(map['users'] as List) : null,
      user: map['user'] != null
          ? WassetProfileModel.fromJson(map['user'] as Map<String, dynamic>)
          : null,
      // token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      user,
      wassetUserId,
      customerUserId,
      isActive,
      lastMessage,
      lastMessageDate,
      token,
      users,
    ];
  }

  ChatEntity toEntity() {
    return ChatEntity(
      id: id,
      user: user?.toEntity(),
      senderUserId: wassetUserId,
      receiverUserId: customerUserId,
      isActive: isActive,
      lastMessage: lastMessage?.toEntity(),
      lastMessageDate: lastMessageDate ?? lastMessage?.createdAt,
      token: token,
      users: users,
    );
  }
}
