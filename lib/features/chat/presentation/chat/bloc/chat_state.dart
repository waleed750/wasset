// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, loaded, error }

class ChatState extends Equatable {
  const ChatState({
    this.messages = const [],
    this.chat = const ChatEntity(),
    this.errorMessage = '',
    this.status = ChatStatus.initial,
    this.name,
    this.chatType,
    this.changed = false,
  });

  final List<MessageEntity> messages;
  final ChatEntity chat;
  final String errorMessage;
  final ChatStatus status;
  final String? name;
  final String? chatType;
  final bool changed;

  ChatState copyWith({
    List<MessageEntity>? messages,
    ChatEntity? chat,
    String? errorMessage,
    ChatStatus? status,
    String? name,
    String? chatType,
    bool? changed,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      chat: chat ?? this.chat,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      name: name ?? this.name,
      chatType: chatType ?? this.chatType,
      changed: changed ?? this.changed,
    );
  }

  @override
  List<Object?> get props =>
      [messages, chat, errorMessage, status, name, chatType, changed];
}
