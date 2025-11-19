// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class UpdateProfileRequest extends Equatable {
  final String name;
  final String email;
  final String identityNumber;
  final String licenseNumber;
  final List<int> wassetSpecialization;
  final String officeName;
  final String officeType;
  final List<int> cities;
  final String phone;
  final bool isBroker;
  const UpdateProfileRequest({
    required this.name,
    required this.email,
    required this.identityNumber,
    required this.licenseNumber,
    required this.wassetSpecialization,
    required this.officeName,
    required this.officeType,
    required this.cities,
    required this.phone,
    this.isBroker = true,
  });

  @override
  List<Object?> get props {
    return [
      name,
      email,
      identityNumber,
      licenseNumber,
      wassetSpecialization,
      officeName,
      officeType,
      cities,
      phone,
      isBroker,
    ];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'identity_number': identityNumber,
      'license_number': licenseNumber,
      'waseet_specialization': wassetSpecialization,
      if (officeName.isNotEmpty) 'office_name': officeName,
      'office_type': officeType.isEmpty ? 'wasset' : officeType,
      'cities': cities,
      'phone': phone,
    };
  }
}
