import 'package:equatable/equatable.dart';
import 'package:waseet/features/tahalf/data/models/tahalf_model/member.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/user/data/models/category_model.dart';
import 'package:waseet/features/user/data/models/home/cities_model.dart';
import 'package:waseet/features/user/data/models/wasset_user_model.dart';

class TahalfModel extends Equatable {
  const TahalfModel({
    this.id,
    this.name,
    this.purpose,
    this.allianceType,
    this.wassetType,
    this.city,
    this.createdBy,
    this.categories,
    this.members,
    this.chatRoomId,
  });

  factory TahalfModel.fromJson(Map<String, dynamic> json) {
    final chatRoom = json['chat_room'] as Map<String, dynamic>;
    return TahalfModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      purpose: json['purpose'] as String?,
      allianceType: json['alliance_type'] as String?,
      city: json['city'] == null
          ? null
          : CitiesModel.fromJson(json['city'] as Map<String, dynamic>),
      createdBy: json['created_by'] == null
          ? null
          : WassetUserModel.fromMap(
              json['created_by'] as Map<String, dynamic>,
            ),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
          .toList(),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => Member.fromJson(e as Map<String, dynamic>))
          .toList(),
      wassetType: json['wasset_type'] is List
          ? (json['wasset_type'] as List).map((e) => e.toString()).toList()
          : json['wasset_type'] is String
              ? [json['wasset_type'] as String]
              : null,
      chatRoomId: chatRoom['id'] as String?,
    );
  }
  final int? id;
  final String? name;
  final String? purpose;
  final String? allianceType;
  final List<String>? wassetType;
  final CitiesModel? city;
  final WassetUserModel? createdBy;
  final List<CategoryModel>? categories;
  final List<Member>? members;
  final String? chatRoomId;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      purpose,
      allianceType,
      wassetType,
      city,
      createdBy,
      categories,
      members,
    ];
  }

  TahalfEntity toEntity() {
    return TahalfEntity.fromModel(this);
  }
}
