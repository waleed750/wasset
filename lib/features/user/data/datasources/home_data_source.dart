import 'dart:developer';

import 'package:waseet/features/user/data/models/home/response/cities_response.dart';
import 'package:waseet/features/user/data/models/home/response/neighborhood_response.dart';
import 'package:waseet/features/user/data/models/home/response/slider_response.dart';
import 'package:waseet/features/user/data/models/response/categories_respones.dart';
import 'package:waseet/features/user/data/models/response/notification_response.dart';
import 'package:waseet/features/user/data/models/response/packages_respones.dart';
import 'package:waseet/features/user/domain/entities/about_us_model.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/entities/neighborhood_entity.dart';
import 'package:waseet/features/user/domain/entities/notification_entity.dart';
import 'package:waseet/features/user/domain/entities/packages_entity.dart';
import 'package:waseet/features/user/domain/entities/slide_entity.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class HomeDataSource {
  const HomeDataSource({required ApiService apiService})
      : _apiService = apiService;

  final ApiService _apiService;

  Future<Resource<List<CitiesEntity>?>> getCities({
    int page = 1,
    int pageSize = 12,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/cities',
        queryParameters: {'pageSize': pageSize, 'page': page},
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responseCities = CitiesResponse.fromMap(response!);

      if (responseCities.data == null) {
        final message = responseCities.message!;
        return Resource.error(
          message,
          null,
          responseCities.errors,
        );
      }

      return Resource.success(
        responseCities.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<SliderEntity>?>> getSlider({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/sliders',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responseSliders = SlidersResponse.fromMap(response!);

      if (responseSliders.data == null) {
        final message = responseSliders.message!;
        return Resource.error(
          message,
          null,
          responseSliders.errors,
        );
      }

      return Resource.success(
        responseSliders.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<CategoryEntity>?>> getCategories({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/category',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responseCategories = CategoriesResponse.fromMap(response!);

      if (responseCategories.data == null) {
        final message = responseCategories.message!;
        return Resource.error(
          message,
          null,
          responseCategories.errors,
        );
      }

      return Resource.success(
        responseCategories.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<NeighborhoodEntity>?>> getNeighborhoods(
    int cityId, {
    int page = 1,
    int pageSize = 12,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/neighborhoods',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
          'city_id': cityId,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responseNeighborhoods = NeighborhoodResponse.fromMap(response!);

      if (responseNeighborhoods.data == null) {
        final message = responseNeighborhoods.message!;
        return Resource.error(
          message,
          null,
          responseNeighborhoods.errors,
        );
      }

      return Resource.success(
        responseNeighborhoods.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<PackagesEntity>?>> getPackages({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/packages',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responsePackages = PackagesResponse.fromMap(response!);

      if (responsePackages.data == null) {
        final message = responsePackages.message!;
        return Resource.error(
          message,
          null,
          responsePackages.errors,
        );
      }

      return Resource.success(
        responsePackages.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<NotificationEntity>?>> getNotifications({
    required int page,
    required int pageSize,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/auth/user-notification',
        queryParameters: {
          'pages': page,
          'pageSize': pageSize,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responseNotification = NotificationResponse.fromMap(response!);

      if (responseNotification.data == null) {
        final message = responseNotification.message!;
        return Resource.error(
          message,
          null,
          responseNotification.errors,
        );
      }

      return Resource.success(
        responseNotification.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<AboutUsModel?>> getAboutUs() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/abouts',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response == null) {
        return Resource.error('error');
      }

      return Resource.success(
        AboutUsModel.fromJson(response['data'] as Map<String, dynamic>),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<String> getTermsAndConditions() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/terms-and-conditions',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response == null) {
        return '';
      }
      final data = response['data'] as List;
      return data.first['content'] as String;
    } on Exception catch (e) {
      log(e.toString());
      return '';
    }
  }
}
