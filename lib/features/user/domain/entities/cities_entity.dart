import 'package:equatable/equatable.dart';

class CitiesEntity extends Equatable {
  const CitiesEntity({
    required this.id,
    required this.name,
    required this.image,
  });

  final int id;
  final String name;
  final String image;

  @override
  List<Object?> get props => [
        id,
        name,
        image,
      ];

  @override
  String toString() {
    return name;
  }
}
