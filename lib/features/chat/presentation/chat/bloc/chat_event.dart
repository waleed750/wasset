part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMessageEvent extends ChatEvent {
  const SendMessageEvent(this.message);
  final AddMessageRequest message;
}

class GetMessagesEvent extends ChatEvent {
  const GetMessagesEvent(this.chatId);
  final String chatId;
}

class GetNewMessagesEvent extends ChatEvent {
  const GetNewMessagesEvent({required this.messages});
  final List<MessageEntity> messages;
}
