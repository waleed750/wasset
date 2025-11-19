part of 'complaint_cubit.dart';

enum ComplaintStatus { initial, loading, loaded, error }

@immutable
class ComplaintState extends Equatable {
  const ComplaintState({
    this.errorMessage = '',
    this.complaints = const [],
    this.status = ComplaintStatus.initial,
  });
  final String errorMessage;
  final List<ComplaintEntity> complaints;
  final ComplaintStatus status;
  @override
  List<Object> get props => [errorMessage, complaints, status];
  ComplaintState copyWith({
    String? errorMessage,
    List<ComplaintEntity>? complaints,
    ComplaintStatus? status,
  }) {
    return ComplaintState(
      errorMessage: errorMessage ?? this.errorMessage,
      complaints: complaints ?? this.complaints,
      status: status ?? this.status,
    );
  }
}

class ComplaintInitial extends ComplaintState {
  const ComplaintInitial() : super();
}
