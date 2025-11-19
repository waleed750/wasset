import 'package:waseet/features/user/data/models/wasset_user/wasset_user/wasset_profile_model.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';

class WassetProfileEntity {
  WassetProfileEntity({
    this.isFav = false,
    this.id,
    this.name,
    this.email,
    this.userId,
    this.identityNumber,
    this.licenseNumber,
    this.officeName,
    this.officeType,
    this.wassetSpecialization,
    this.cities,
    this.profileImage,
    this.visitorsCount,
    this.averageRating,
    this.isGolden,
    this.phone,
    this.gender,
    this.isVerified,
  });

  factory WassetProfileEntity.fromModel(WassetProfileModel entity) {
    return WassetProfileEntity(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      userId: entity.userId,
      identityNumber: entity.identityNumber,
      licenseNumber: entity.licenseNumber,
      officeName: entity.officeName,
      officeType: entity.officeType,
      wassetSpecialization:
          entity.wassetSpecialization?.map((e) => e.toEntity()).toList(),
      cities: entity.cities?.map((e) => e.toEntity()).toList(),
      profileImage: entity.profileImage,
      visitorsCount: entity.visitorsCount,
      averageRating: entity.averageRating,
      isGolden: entity.isGolden,
      phone: entity.phone,
      gender: entity.gender,
      isVerified: entity.isVerifiedByNafath,
    );
  }

  int? id;
  String? name;
  String? email;
  int? userId;
  String? identityNumber;
  String? licenseNumber;
  String? officeName;
  String? officeType;
  List<CategoryEntity>? wassetSpecialization;
  List<CitiesEntity>? cities;
  String? profileImage;
  bool isFav;
  int? visitorsCount;
  double? averageRating;
  bool? isGolden;
  String? phone;
  String? gender;
  bool? isVerified;

  bool get isWasset => officeType == 'wasset';
}
