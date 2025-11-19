part of 'policies_and_provisions_cubit.dart';

enum PoliciesAndProvisionsStatus { initial, loading, loaded, error }

class PoliciesAndProvisionsState extends Equatable {
  const PoliciesAndProvisionsState({
    this.status = PoliciesAndProvisionsStatus.initial,
    this.errorMessage = '',
  });

  final PoliciesAndProvisionsStatus status;
  final String errorMessage;

  @override
  List<Object> get props {
    return [
      status,
    ];
  }

  PoliciesAndProvisionsState copyWith({
    PoliciesAndProvisionsStatus? status,
    String? errorMessage,
  }) {
    return PoliciesAndProvisionsState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class PoliciesAndProvisionsInitial extends PoliciesAndProvisionsState {
  const PoliciesAndProvisionsInitial() : super();
}
