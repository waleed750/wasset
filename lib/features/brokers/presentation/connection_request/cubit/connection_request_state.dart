// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'connection_request_cubit.dart';

enum ConnectionRequestStatus {
  initial,
  loading,
  loaded,
  error,
  processLoading,
  processFailure,
  processSuccess,
  addLoading,
  addAndRemoveSuccess,
  addAndRemoveFailure,
  removeLoading,
  startingChatLoading,
  startingChatSuccess,
  startingChatFailure,
}

class ConnectionRequestState extends Equatable {
  const ConnectionRequestState({
    this.list = const [],
    this.favList = const [],
    this.todayList = const [],
    this.status = ConnectionRequestStatus.initial,
    this.fav = false,
    this.errorMessage = '',
    this.processMessage,
    this.description,
    this.chatAndDetails,
  });

  final List<ConnectionRequestEntity> list;
  final List<ConnectionRequestEntity> favList;
  final List<ConnectionRequestEntity> todayList;
  final ConnectionRequestStatus status;
  final String? processMessage;
  final bool fav;
  final String errorMessage;
  final String? description;
  final ChatAndDetailsEntity? chatAndDetails;
  @override
  List<Object?> get props {
    return [
      list,
      favList,
      todayList,
      status,
      processMessage,
      fav,
      errorMessage,
      description,
      chatAndDetails,
    ];
  }

  ConnectionRequestState copyWith({
    List<ConnectionRequestEntity>? list,
    List<ConnectionRequestEntity>? favList,
    List<ConnectionRequestEntity>? todayList,
    ConnectionRequestStatus? status,
    String? processMessage,
    bool? fav,
    String? errorMessage,
    String? description,
    ChatAndDetailsEntity? chatAndDetails,
  }) {
    return ConnectionRequestState(
      list: list ?? this.list,
      favList: favList ?? this.favList,
      todayList: todayList ?? this.todayList,
      status: status ?? this.status,
      processMessage: processMessage ?? this.processMessage,
      fav: fav ?? this.fav,
      errorMessage: errorMessage ?? this.errorMessage,
      description: description ?? this.description,
      chatAndDetails: chatAndDetails ?? this.chatAndDetails,
    );
  }
}

class ConnectionRequestInitial extends ConnectionRequestState {
  const ConnectionRequestInitial() : super();
}
