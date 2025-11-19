import 'dart:convert';

import 'package:waseet/features/user/data/models/wasset_user/wasset_user/wasset_profile_model.dart';

class WassetUserModel {
  WassetUserModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.type,
    this.profile,
    this.gender,
  });

  factory WassetUserModel.fromMap(Map<String, dynamic> data) => WassetUserModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        email: data['email'] as String?,
        phone: data['phone'] as String?,
        type: data['type'] as String?,
        profile: data['profile'] == null
            ? null
            : WassetProfileModel.fromJson(
                data['profile'] as Map<String, dynamic>,
              ),
        gender: data['gender'] as String?,
      );

  factory WassetUserModel.fromJson(String data) {
    return WassetUserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  int? id;
  String? name;
  String? email;
  String? phone;
  String? type;
  WassetProfileModel? profile;
  String? gender;
}
