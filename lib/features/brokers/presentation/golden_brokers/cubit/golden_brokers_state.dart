part of 'golden_brokers_cubit.dart';

enum GoldenBrokersStatus { initial, loading, loaded, error }

class GoldenBrokersState extends Equatable {
  const GoldenBrokersState({
    this.customProperty = 'Default Value',
    this.list = const [],
    this.status = GoldenBrokersStatus.initial,
  });

  final String customProperty;
  final List<GoldenBrokersEntity> list;
  final GoldenBrokersStatus status;

  @override
  List<Object> get props => [
        customProperty,
        list,
        status,
      ];

  /// Creates a copy of the current GoldenBrokersState with property changes
  GoldenBrokersState copyWith({
    String? customProperty,
    List<GoldenBrokersEntity>? list,
    GoldenBrokersStatus? status,
  }) {
    return GoldenBrokersState(
      customProperty: customProperty ?? this.customProperty,
      list: list ?? this.list,
      status: status ?? this.status,
    );
  }
}

class GoldenBrokersInitial extends GoldenBrokersState {
  const GoldenBrokersInitial() : super();
}
