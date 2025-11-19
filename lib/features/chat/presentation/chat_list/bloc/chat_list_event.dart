part of 'chat_list_bloc.dart';

sealed class ChatListEvent extends Equatable {
  const ChatListEvent();

  @override
  List<Object> get props => [];
}

final class ChatListLoad extends ChatListEvent {}

final class ChatListRefresh extends ChatListEvent {
  const ChatListRefresh({required this.chats});
  final List<ChatEntity> chats;

  @override
  List<Object> get props => [chats];
}
