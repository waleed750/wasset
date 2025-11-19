import 'package:equatable/equatable.dart';
import 'package:waseet/features/tahalf/data/models/tahalf_model/member.dart';
import 'package:waseet/features/tahalf/data/models/tahalf_model/tahalf_model.dart';
import 'package:waseet/features/user/data/models/wasset_user_model.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';

class TahalfEntity extends Equatable {
  const TahalfEntity({
    this.id,
    this.allianceType,
    this.createdBy,
    this.members,
    this.purpose,
    this.wassetType,
    this.city,
    this.categories,
    this.name,
    this.chatRoomId,
  });
  factory TahalfEntity.fromModel(TahalfModel entity) {
    return TahalfEntity(
      categories: entity.categories?.map((e) => e.toEntity()).toList(),
      city: entity.city?.toEntity(),
      name: entity.name,
      purpose: entity.purpose,
      wassetType: entity.wassetType,
      allianceType: entity.allianceType,
      id: entity.id,
      createdBy: entity.createdBy,
      members: entity.members,
      chatRoomId: entity.chatRoomId,
    );
  }

  final int? id;
  final String? name;
  final String? purpose;
  final String? allianceType;
  final List<String>? wassetType;
  final CitiesEntity? city;
  final WassetUserModel? createdBy;
  final List<CategoryEntity>? categories;
  final List<Member>? members;
  final String? chatRoomId;

  @override
  List<Object?> get props => [
        id,
        name,
        purpose,
        allianceType,
        wassetType,
        city,
        createdBy,
        categories,
        members,
        chatRoomId,
      ];
}
