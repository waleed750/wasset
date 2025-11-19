import 'package:waseet/features/brokers/domain/entities/golden_brokers_entity.dart';
import 'package:waseet/features/user/data/models/category_model.dart';
import 'package:waseet/features/user/data/models/home/cities_model.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';

class WassetProfileModel {
  WassetProfileModel({
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
    this.isVerifiedByNafath,
  });

  factory WassetProfileModel.fromJson(Map<String, dynamic> json) =>
      WassetProfileModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        userId: json['user_id'] as int?,
        identityNumber: json['identity_number'] as String?,
        licenseNumber: json['license_number'] as String?,
        officeName: json['office_name'] as String?,
        officeType: json['office_type'] as String?,
        wassetSpecialization: (json['waseet_specialization'] as List<dynamic>?)
            ?.map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        cities: (json['cities'] as List<dynamic>?)
            ?.map((e) => CitiesModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        // profileImage: json['profile_image'] is List
        //     ? null
        //     : json['profile_image'] as String?,
        profileImage: json['profile_image'] as String?,
        visitorsCount: json['visitors_count'] as int?,
        averageRating: (json['average_rating'] as num?)?.toDouble(),
        isGolden: int.tryParse(json['is_golden'].toString()) == 1,
        phone: json['phone'] as String?,
        gender: json['gender'] as String?,
        isVerifiedByNafath: json['is_verified_by_nafath'] == 1,
      );

  int? id;
  String? name;
  String? email;
  int? userId;
  String? identityNumber;
  String? licenseNumber;
  String? officeName;
  String? officeType;
  List<CategoryModel>? wassetSpecialization;
  List<CitiesModel>? cities;
  String? profileImage;
  double? rate;
  int? visitorsCount;
  double? averageRating;
  bool? isGolden;
  String? phone;
  String? gender;
  bool? isVerifiedByNafath;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'user_id': userId,
        'identity_number': identityNumber,
        'license_number': licenseNumber,
        'office_name': officeName,
        'office_type': officeType,
        'wasset_specialization':
            wassetSpecialization?.map((e) => e.toJson()).toList(),
        'cities': cities?.map((e) => e.toJson()).toList(),
        'profile_image': profileImage,
      };

  WassetProfileEntity toEntity() {
    return WassetProfileEntity(
      id: id,
      name: name,
      email: email,
      userId: userId,
      identityNumber: identityNumber,
      licenseNumber: licenseNumber,
      officeName: officeName,
      officeType: officeType,
      wassetSpecialization:
          wassetSpecialization?.map((e) => e.toEntity()).toList(),
      cities: cities?.map((e) => e.toEntity()).toList(),
      profileImage: profileImage,
      visitorsCount: visitorsCount,
      averageRating: averageRating,
      isGolden: isGolden,
      phone: phone,
      gender: gender,
      isVerified: isVerifiedByNafath,
    );
  }

  GoldenBrokersEntity toGoldenBroker() {
    return GoldenBrokersEntity(
      customerId: userId.toString(),
      articleId: 'articleId',
      article: 'article',
      photo: profileImage ?? '',
      name: name!,
    );
  }
}
