// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'my_connection_request_cubit.dart';

enum MyConnectionRequestStatus {
  initial,
  loading,
  loaded,
  error,
  processFailure,
  processSuccess,
  processLoading,
}

class MyConnectionRequestState extends Equatable {
  const MyConnectionRequestState(
      {this.list = const [],
      this.status = MyConnectionRequestStatus.initial,
      this.errorMessage = '',
      this.processMessage});

  final List<ConnectionRequestEntity> list;
  final MyConnectionRequestStatus status;
  final String errorMessage;
  final String? processMessage;
  @override
  List<Object?> get props {
    return [
      list,
      status,
      errorMessage,
      processMessage,
    ];
  }

  MyConnectionRequestState copyWith({
    List<ConnectionRequestEntity>? list,
    MyConnectionRequestStatus? status,
    String? errorMessage,
    String? processMessage,
  }) {
    return MyConnectionRequestState(
      list: list ?? this.list,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      processMessage: processMessage ?? this.processMessage,
    );
  }
}

class MyConnectionRequestInitial extends MyConnectionRequestState {
  const MyConnectionRequestInitial() : super();
}
