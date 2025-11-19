// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final int? id;
  final String? name;
  final String? email;
  final int? userId;
  final List<dynamic>? communcationsRequests;
  final String? phone;
  final dynamic identityNumber;
  final dynamic licenseNumber;
  final dynamic officeName;
  final dynamic officeType;
  final int? isGolden;
  final int? visitorsCount;
  final List<dynamic>? wassetSpecialization;
  final List<dynamic>? cities;
  final dynamic profileImage;
  final List<dynamic>? rating;
  final dynamic averageRating;
  final String? gender;

  const Profile({
    this.id,
    this.name,
    this.email,
    this.userId,
    this.communcationsRequests,
    this.phone,
    this.identityNumber,
    this.licenseNumber,
    this.officeName,
    this.officeType,
    this.isGolden,
    this.visitorsCount,
    this.wassetSpecialization,
    this.cities,
    this.profileImage,
    this.rating,
    this.averageRating,
    this.gender,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        id: json['id'] as int?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        userId: json['user_id'] as int?,
        communcationsRequests: json['communcations_requests'] as List<dynamic>?,
        phone: json['phone'] as String?,
        identityNumber: json['identity_number'] as dynamic,
        licenseNumber: json['license_number'] as dynamic,
        officeName: json['office_name'] as dynamic,
        officeType: json['office_type'] as dynamic,
        isGolden: json['is_golden'] as int?,
        visitorsCount: json['visitors_count'] as int?,
        wassetSpecialization: json['wasset_specialization'] as List<dynamic>?,
        cities: json['cities'] as List<dynamic>?,
        profileImage: json['profile_image'] as dynamic,
        rating: json['rating'] as List<dynamic>?,
        averageRating: json['average_rating'] as dynamic,
        gender: json['gender'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'user_id': userId,
        'communcations_requests': communcationsRequests,
        'phone': phone,
        'identity_number': identityNumber,
        'license_number': licenseNumber,
        'office_name': officeName,
        'office_type': officeType,
        'is_golden': isGolden,
        'visitors_count': visitorsCount,
        'wasset_specialization': wassetSpecialization,
        'cities': cities,
        'profile_image': profileImage,
        'rating': rating,
        'average_rating': averageRating,
      };

  @override
  List<Object?> get props {
    return [
      id,
      name,
      email,
      userId,
      communcationsRequests,
      phone,
      identityNumber,
      licenseNumber,
      officeName,
      officeType,
      isGolden,
      visitorsCount,
      wassetSpecialization,
      cities,
      profileImage,
      rating,
      averageRating,
      gender,
    ];
  }
}
