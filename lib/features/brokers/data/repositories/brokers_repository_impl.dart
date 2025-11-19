import 'package:waseet/features/brokers/data/datasources/broker_data_source.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/domain/entities/fav_broker_entity.dart';
import 'package:waseet/features/brokers/domain/entities/golden_brokers_entity.dart';
import 'package:waseet/features/brokers/domain/repositories/brokers_repository.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/res/resource.dart';

class BrokerRepositoryImpl implements BrokerRepository {
  BrokerRepositoryImpl({
    required BrokerDataSource dataSource,
  }) : _dataSource = dataSource;

  final BrokerDataSource _dataSource;

  @override
  Future<Resource<List<WassetProfileEntity?>?>> getBrokers({
    int? cityId,
  }) async {
    try {
      final broker = await _dataSource.getBrokers(cityId: cityId);
      if (broker is ResourceError) {
        return Resource.error(broker.message!, null, broker.errors);
      }
      return Resource.success(
        broker.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<List<GoldenBrokersEntity>?>> getGoldenBrokers({
    int? cityId,
  }) async {
    try {
      final broker = await _dataSource.getGoldenBrokers(cityId: cityId);
      if (broker is ResourceError) {
        return Resource.error(broker.message!, null, broker.errors);
      }
      return Resource.success(
        broker.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String?>> addFavBrokers(
    String brokerId,
  ) async {
    try {
      final favBroker = await _dataSource.addFavBrokers(brokerId);
      if (favBroker is ResourceError) {
        return Resource.error(favBroker.message!, null, favBroker.errors);
      }
      return Resource.success(
        favBroker.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<String?>> removeFavBrokers(
    String brokerId,
  ) async {
    try {
      final favBroker = await _dataSource.removeFavBrokers(brokerId);
      if (favBroker is ResourceError) {
        return Resource.error(favBroker.message!, null, favBroker.errors);
      }
      return Resource.success(
        favBroker.data,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Resource<List<FavBrokerEntity?>?>> getFavBrokers({int? cityId}) async {
    try {
      final broker = await _dataSource.getFavBrokers(cityId: cityId);
      if (broker is ResourceError) {
        return Resource.error(broker.message!, null, broker.errors);
      }
      return Resource.success(
        broker.data,
      );
    } catch (e) {
      rethrow;
    }
  }
}
