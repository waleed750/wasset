import 'package:equatable/equatable.dart';
import 'package:waseet/features/user/domain/entities/slide_entity.dart';

class SliderModel extends Equatable {
  const SliderModel({
    this.id,
    this.name,
    this.image,
    this.orderBy,
    this.createdAt,
    this.updatedAt,
  });

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        image: json['image'] as String?,
        orderBy: json['order_by'] as int?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
      );
  final int? id;
  final String? name;
  final String? image;
  final int? orderBy;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'image': image,
        'order_by': orderBy,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };

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

  SliderEntity toEntity() {
    return SliderEntity(
      createdAt: createdAt,
      id: id!,
      image: image!,
      name: name!,
      orderBy: orderBy,
      updatedAt: updatedAt,
    );
  }
}
