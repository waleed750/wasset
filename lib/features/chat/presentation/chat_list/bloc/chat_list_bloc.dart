import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/chat/domain/entities/chat_entity.dart';
import 'package:waseet/features/chat/domain/repositories/chat_repository.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/features/user/domain/repositories/authentication_repository.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc({
    required ChatRepository chatRepository,
    required AuthenticationRepository authenticationRepository,
    required int myId,
  })  : _chatRepository = chatRepository,
        _authenticationRepository = authenticationRepository,
        _myId = myId,
        super(ChatListInitial()) {
    on<ChatListLoad>(_onLoad);
    on<ChatListRefresh>(_onRefresh);
    add(ChatListLoad());
  }

  final ChatRepository _chatRepository;
  late final StreamSubscription<List<ChatEntity>> _chatSubscription;
  final AuthenticationRepository _authenticationRepository;
  final int _myId;

  FutureOr<void> _onLoad(
    ChatListLoad event,
    Emitter<ChatListState> emit,
  ) async {
    emit(ChatListLoading());
    try {
      final result = await _chatRepository.getChatsFromApi(_myId);
      emit(ChatListLoaded(chats: result));

      _chatSubscription = _chatRepository.getChats(_myId).listen((chats) {
        add(ChatListRefresh(chats: chats));
      });
    } catch (e) {
      emit(ChatListError(message: e.toString()));
    }
  }

  final List<WassetProfileEntity> _profiles = [];

  FutureOr<void> _onRefresh(
    ChatListRefresh event,
    Emitter<ChatListState> emit,
  ) async {
    final chats = <ChatEntity>[];
    for (final element in event.chats) {
      try {
        if (_profiles.any(
          (profile) =>
              profile.id ==
              element.users!.firstWhere((element) => element != _myId),
        )) {
          continue;
        }
        final profile = (await _authenticationRepository.getProfileById(
          element.users!.firstWhere((element) => element != _myId).toString(),
        ))
            .data;
        chats.add(element.copyWith(user: profile));
        _profiles.add(profile!);
      } catch (e) {}
    }
    chats.sort(
      (a, b) => b.lastMessageDate!.compareTo(a.lastMessageDate!),
    );
    emit(ChatListLoaded(chats: chats));
  }

  @override
  Future<void> close() {
    _chatSubscription.cancel();
    return super.close();
  }
}
