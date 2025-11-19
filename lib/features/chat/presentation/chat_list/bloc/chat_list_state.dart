part of 'chat_list_bloc.dart';

sealed class ChatListState extends Equatable {
  const ChatListState();

  @override
  List<Object> get props => [];
}

final class ChatListInitial extends ChatListState {}

final class ChatListLoading extends ChatListState {}

final class ChatListLoaded extends ChatListState {
  const ChatListLoaded({required this.chats});
  final List<ChatEntity> chats;

  @override
  List<Object> get props => [chats];
}

final class ChatListError extends ChatListState {
  const ChatListError({required this.message, this.chats = const []});
  final String message;
  final List<ChatEntity> chats;

  @override
  List<Object> get props => [message, chats];
}
