// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:waseet/features/chat/domain/entities/message_model.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';

class ChatEntity extends Equatable {
  final String? id;
  final WassetProfileEntity? user;
  final String? senderUserId;
  final String? receiverUserId;
  final bool? isActive;
  final MessageEntity? lastMessage;
  final DateTime? lastMessageDate;
  final String? token;
  final List<int>? users;
  const ChatEntity({
    this.id,
    this.user,
    this.senderUserId,
    this.receiverUserId,
    this.isActive,
    this.lastMessage,
    this.lastMessageDate,
    this.token,
    this.users,
  });

  static ChatEntity empty() => const ChatEntity();

  ChatEntity copyWith({
    String? id,
    WassetProfileEntity? user,
    String? senderUserId,
    String? receiverUserId,
    bool? isActive,
    MessageEntity? lastMessage,
    DateTime? lastMessageDate,
    String? token,
    List<int>? users,
  }) {
    return ChatEntity(
      id: id ?? this.id,
      user: user ?? this.user,
      senderUserId: senderUserId ?? this.senderUserId,
      receiverUserId: receiverUserId ?? this.receiverUserId,
      isActive: isActive ?? this.isActive,
      lastMessage: lastMessage ?? this.lastMessage,
      lastMessageDate: lastMessageDate ?? this.lastMessageDate,
      token: token ?? this.token,
      users: users ?? this.users,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      user,
      senderUserId,
      receiverUserId,
      isActive,
      lastMessage,
      lastMessageDate,
      token,
      users,
    ];
  }
}
