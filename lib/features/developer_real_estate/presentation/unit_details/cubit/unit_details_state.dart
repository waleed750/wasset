part of 'unit_details_cubit.dart';

enum UnitDetailsStatus {
  initial,
  loading,
  loaded,
  error,
}

class UnitDetailsState extends Equatable {
  const UnitDetailsState({
    this.status = UnitDetailsStatus.initial,
    this.unit,
    this.errorMessage = '',
  });

  final UnitDetailsStatus status;
  final DeveloperUnitEntity? unit;
  final String errorMessage;

  @override
  List<Object?> get props => [status, unit, errorMessage];

  UnitDetailsState copyWith({
    UnitDetailsStatus? status,
    DeveloperUnitEntity? unit,
    String? errorMessage,
  }) {
    return UnitDetailsState(
      status: status ?? this.status,
      unit: unit ?? this.unit,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
