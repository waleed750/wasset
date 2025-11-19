import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/chat/domain/entities/chat_entity.dart';
import 'package:waseet/features/chat/domain/entities/message_model.dart';
import 'package:waseet/features/chat/domain/entities/request/add_message_request.dart';
import 'package:waseet/features/chat/domain/repositories/chat_repository.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({
    required ChatRepository chatRepository,
    String? chatType,
    String? name,
    String chatId = '',
  })  : _chatId = chatId,
        _chatRepository = chatRepository,
        super(
          ChatState(
            name: name,
            chatType: chatType,
          ),
        ) {
    on<GetMessagesEvent>(_onGetMessages);
    on<SendMessageEvent>(_onSendMessage);
    on<GetNewMessagesEvent>(_onGetNewMessages);
    add(
      GetMessagesEvent(
        chatId,
      ),
    );
  }

  final ChatRepository _chatRepository;
  late final StreamSubscription<List<MessageEntity>> _messagesSubscription;
  final String _chatId;
  FutureOr<void> _onGetMessages(
    GetMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(status: ChatStatus.loading));
    try {
      _messagesSubscription = _chatRepository
          .getMessages(event.chatId, isTahaluf: state.chatType == 'tahalf')
          .listen((messages) {
        add(GetNewMessagesEvent(messages: messages));
      });
    } catch (e) {
      emit(
        state.copyWith(status: ChatStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onSendMessage(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(state.copyWith(status: ChatStatus.loading));
    try {
      await _chatRepository.sendMessage(
        event.message.copyWith(chatId: _chatId),
        isTahaluf: state.chatType == 'tahalf',
      );
      emit(state.copyWith(status: ChatStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(status: ChatStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onGetNewMessages(
    GetNewMessagesEvent event,
    Emitter<ChatState> emit,
  ) async {
    event.messages.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    emit(state.copyWith(messages: event.messages, changed: !state.changed));
  }

  @override
  Future<void> close() {
    _messagesSubscription.cancel();
    return super.close();
  }
}
