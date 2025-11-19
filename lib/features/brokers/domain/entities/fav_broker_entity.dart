import 'package:waseet/features/user/data/models/wasset_user_model.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';

class FavBrokerEntity {
  const FavBrokerEntity({
    this.profile,
  });

  factory FavBrokerEntity.fromModel(WassetUserModel entity) {
    return FavBrokerEntity(
      profile: entity.profile == null
          ? null
          : WassetProfileEntity.fromModel(entity.profile!),
    );
  }

  final WassetProfileEntity? profile;
}
