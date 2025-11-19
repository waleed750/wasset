// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:waseet/features/user/data/models/wasset_user_model.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';

class WassetUser {
  const WassetUser({
    required this.id,
    required this.email,
    required this.name,
    this.type,
    this.phone,
    this.profile,
    this.gender,
  });

  factory WassetUser.fromModel(WassetUserModel entity) {
    return WassetUser(
      id: entity.id!,
      email: entity.email!,
      name: entity.name!,
      type: entity.type?.toUserType(),
      phone: entity.phone,
      profile: entity.profile == null
          ? null
          : WassetProfileEntity.fromModel(entity.profile!),
      gender: entity.gender,
    );
  }
  final int id;
  final String email;
  final String name;
  final UserType? type;
  final String? phone;
  final WassetProfileEntity? profile;
  final String? gender;

  bool get isBroker => type == UserType.wasset;

  static WassetUser empty() {
    return const WassetUser(
      id: 999999999999999,
      email: '',
      name: '',
      type: UserType.customer,
    );
  }
}

enum UserType { customer, wasset }

extension UserTypeX on String {
  UserType? toUserType() {
    switch (this) {
      case 'customer':
        return UserType.customer;
      case 'wasset':
        return UserType.wasset;
      default:
        return UserType.customer;
    }
  }
}
