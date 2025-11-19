import 'package:equatable/equatable.dart';

import 'pivot.dart';

class Role extends Equatable {
  final int? id;
  final String? name;
  final String? guardName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Pivot? pivot;

  const Role({
    this.id,
    this.name,
    this.guardName,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json['id'] as int?,
        name: json['name'] as String?,
        guardName: json['guard_name'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        pivot: json['pivot'] == null
            ? null
            : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'guard_name': guardName,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'pivot': pivot?.toJson(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      guardName,
      createdAt,
      updatedAt,
      pivot,
    ];
  }
}
