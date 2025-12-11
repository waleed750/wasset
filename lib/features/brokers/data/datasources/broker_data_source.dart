import 'dart:developer';

import 'package:waseet/features/brokers/data/models/response/broker_response.dart';
import 'package:waseet/features/brokers/domain/entities/fav_broker_entity.dart';
import 'package:waseet/features/brokers/domain/entities/golden_brokers_entity.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class BrokerDataSource {
  BrokerDataSource({
    required ApiService apiService,
  }) : _apiService = apiService;
  final ApiService _apiService;

  Future<Resource<List<WassetProfileEntity?>?>> getBrokers({
    int? cityId,
    int page = 1,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/auth/get-all-wasset-kingdom',
        queryParameters: {
          if (cityId != null) 'filter[city_id]': cityId,
          'page': page,
          'pageSize': 10,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );
      final responseBroker = BrokersResponse.fromMap(response!);
      if (responseBroker.data == null) {
        final message = responseBroker.message ?? 'حدث خطأ ما';
        return Resource.error(
          message,
          null,
          responseBroker.errors,
        );
      }
      return Resource.success(
        responseBroker.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<FavBrokerEntity?>?>> getFavBrokers({
    int? cityId,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/favorites',
        queryParameters: {
          'filter[city_id]': cityId,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );
      final responseFavBroker = FavBrokersResponse.fromMap(response!);
      if (responseFavBroker.data == null) {
        final message = responseFavBroker.message!;
        return Resource.error(
          message,
          null,
          responseFavBroker.errors,
        );
      }
      return Resource.success(
        responseFavBroker.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  // Future<Resource<List<GoldenBrokersEntity>>> getGoldenBrokers({
  //   int? cityId,
  // }) async {
  //   try {
  //     final response = await _apiService.get<Map<String, dynamic>>(
  //       '/auth/get-all-wasset-kingdom',
  //       queryParameters: {
  //         'filter[is_golden]': true,
  //       },
  //       headers: {
  //         'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
  //       },
  //     );
  //     final responseBroker = BrokersResponse.fromMap(response!);
  //     if (responseBroker.data == null) {
  //       final message = responseBroker.message!;
  //       return Resource.error(
  //         message,
  //         null,
  //         responseBroker.errors,
  //       );
  //     }
  //     return Resource.success(
  //       responseBroker.data!.map((e) => e.toGoldenBroker()).toList(),
  //     );
  //   } on Exception catch (e) {
  //     log(e.toString());
  //     return Resource.error(e.toString());
  //   }
  // }

  Future<Resource<String?>> addFavBrokers(
    String brokerId,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/favorites/add/$brokerId',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );
      if (response!['message'] == 'تم إضافة المستخدم إلى المفضلة') {
        return Resource.success(
          response['message'] as String,
        );
      }
      final message = response['message'] as String;
      return Resource.error(
        message,
        null,
        response['errors'] as Map<String, dynamic>?,
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<GoldenBrokersEntity>>> getGoldenBrokers({
    int? cityId,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/auth/get-all-wasset-kingdom',
        queryParameters: {
          'filter[is_golden]': true,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );
      final responseBroker = BrokersResponse.fromMap(response!);
      if (responseBroker.data == null) {
        final message = responseBroker.message!;
        return Resource.error(
          message,
          null,
          responseBroker.errors,
        );
      }
      return Resource.success(
        responseBroker.data!.map((e) => e.toGoldenBroker()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String?>> removeFavBrokers(
    String brokerId,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/favorites/remove/$brokerId',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['message'] == 'تم إزالة المستخدم من المفضلة بنجاح') {
        return Resource.success(
          response['message'] as String,
        );
      }
      final message = response['message'] as String;
      return Resource.error(
        message,
        null,
        response['errors'] as Map<String, dynamic>?,
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }
}
