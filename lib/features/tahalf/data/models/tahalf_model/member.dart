import 'package:equatable/equatable.dart';

import 'package:waseet/features/tahalf/data/models/tahalf_model/pivot.dart';
import 'package:waseet/features/tahalf/data/models/tahalf_model/role.dart';

class Member extends Equatable {
  const Member({
    this.id,
    this.name,
    this.email,
    this.gender,
    this.isActive,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.type,
    this.pivot,
    this.permissions,
    this.roles,
  });

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        gender: json['gender'] as String?,
        isActive: json['is_active'] as int?,
        phone: json['phone'] as String?,
        createdAt: json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String),
        type: json['type'] as String?,
        pivot: json['pivot'] == null
            ? null
            : Pivot.fromJson(json['pivot'] as Map<String, dynamic>),
        permissions: json['permissions'] as List<dynamic>?,
        roles: (json['roles'] as List<dynamic>?)
            ?.map((e) => Role.fromJson(e as Map<String, dynamic>))
            .toList(),
      );
  final int? id;
  final String? name;
  final String? email;
  final String? gender;
  final int? isActive;
  final String? phone;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? type;
  final Pivot? pivot;
  final List<dynamic>? permissions;
  final List<Role>? roles;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'gender': gender,
        'is_active': isActive,
        'phone': phone,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'type': type,
        'pivot': pivot?.toJson(),
        'permissions': permissions,
        'roles': roles?.map((e) => e.toJson()).toList(),
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      gender,
      isActive,
      phone,
      createdAt,
      updatedAt,
      type,
      pivot,
      permissions,
      roles,
    ];
  }
}
