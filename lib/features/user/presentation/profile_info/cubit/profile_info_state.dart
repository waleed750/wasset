// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'profile_info_cubit.dart';

enum ProfileInfoStatus { initial, loading, loaded, error, updated, updating }

/// {@template profile_info}
/// ProfileInfoState description
/// {@endtemplate}
class ProfileInfoState extends Equatable {
  /// {@macro profile_info}
  const ProfileInfoState({
    this.errorMessage = '',
    this.status = ProfileInfoStatus.initial,
    this.cities = const [],
    this.categories = const [],
    this.name,
    this.identityNumber,
    this.licenseNumber,
    this.email = const EmailValidationField.pure(),
    this.brokerSpecialization,
    this.officeName,
    this.officeType,
    this.citiesList,
    this.selectedCategory,
    this.profile,
    this.phone,
  });

  final String errorMessage;
  final ProfileInfoStatus status;
  final List<CitiesEntity> cities;
  final List<CategoryEntity> categories;
  final String? name;
  final String? identityNumber;
  final String? licenseNumber;
  final EmailValidationField email;
  final List<CategoryEntity>? brokerSpecialization;
  final String? officeName;
  final BrokerType? officeType;
  final List<CitiesEntity>? citiesList;
  final CategoryEntity? selectedCategory;
  final WassetUser? profile;
  final String? phone;

  @override
  List<Object?> get props {
    return [
      errorMessage,
      status,
      cities,
      categories,
      name,
      identityNumber,
      licenseNumber,
      email,
      brokerSpecialization,
      officeName,
      officeType,
      citiesList,
      selectedCategory,
      profile,
      phone,
    ];
  }

  /// Creates a copy of the current ProfileInfoState with property changes
  ProfileInfoState copyWith({
    String? errorMessage,
    ProfileInfoStatus? status,
    List<CitiesEntity>? cities,
    List<CategoryEntity>? categories,
    String? name,
    String? identityNumber,
    String? licenseNumber,
    EmailValidationField? email,
    List<CategoryEntity>? brokerSpecialization,
    String? officeName,
    BrokerType? officeType,
    List<CitiesEntity>? citiesList,
    CategoryEntity? selectedCategory,
    WassetUser? profile,
    String? phone,
  }) {
    return ProfileInfoState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      cities: cities ?? this.cities,
      categories: categories ?? this.categories,
      name: name ?? this.name,
      identityNumber: identityNumber ?? this.identityNumber,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      email: email ?? this.email,
      brokerSpecialization: brokerSpecialization ?? this.brokerSpecialization,
      officeName: officeName ?? this.officeName,
      officeType: officeType ?? this.officeType,
      citiesList: citiesList ?? this.citiesList,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      profile: profile ?? this.profile,
      phone: phone ?? this.phone,
    );
  }
}
