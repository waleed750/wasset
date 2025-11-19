import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:waseet/features/brokers/domain/entities/fav_broker_entity.dart';
import 'package:waseet/features/user/data/models/wasset_user/wasset_user/wasset_profile_model.dart';

class FavBrokerModel extends Equatable {
  const FavBrokerModel({this.profile});

  factory FavBrokerModel.fromMap(Map<String, dynamic> json) {
    return FavBrokerModel(
      profile: json['profile'] == null
          ? null
          : WassetProfileModel.fromJson(
              json['profile'] as Map<String, dynamic>),
    );
  }
  factory FavBrokerModel.fromJson(String data) {
    return FavBrokerModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  final WassetProfileModel? profile;
  FavBrokerEntity toEntity() {
    return FavBrokerEntity(
      profile: profile?.toEntity(),
    );
  }

  @override
  List<Object?> get props => [profile];
}
