import 'package:waseet/features/brokers/domain/entities/fav_broker_entity.dart';
import 'package:waseet/features/brokers/domain/entities/golden_brokers_entity.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/res/resource.dart';

abstract class BrokerRepository {
  Future<Resource<List<GoldenBrokersEntity>?>> getGoldenBrokers({int? cityId});
  Future<Resource<List<WassetProfileEntity?>?>> getBrokers({int? cityId});
  Future<Resource<List<FavBrokerEntity?>?>> getFavBrokers({int? cityId});
  Future<Resource<String?>> addFavBrokers(String brokerId);
  Future<Resource<String?>> removeFavBrokers(String brokerId);
}
