import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable {
  const SliderEntity({
    required this.id,
    required this.name,
    required this.image,
    this.orderBy,
    this.createdAt,
    this.updatedAt,
  });
  final int id;
  final String name;
  final String image;
  final int? orderBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      image,
      orderBy,
      createdAt,
      updatedAt,
    ];
  }
}
