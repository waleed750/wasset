import 'package:equatable/equatable.dart';

class NeighborhoodEntity extends Equatable {
  const NeighborhoodEntity({
    required this.id,
    required this.name,
  });

  final int id;
  final String name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];

  @override
  String toString() {
    return name;
  }
}
