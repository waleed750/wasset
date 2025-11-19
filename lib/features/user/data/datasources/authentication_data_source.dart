import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:waseet/features/user/data/models/my_subscription_model.dart';
import 'package:waseet/features/user/data/models/response/user_response%20copy.dart';
import 'package:waseet/features/user/data/models/response/user_response.dart';
import 'package:waseet/features/user/data/models/subscription_model/subscription_model.dart';
import 'package:waseet/features/user/domain/entities/request/login_request.dart';
import 'package:waseet/features/user/domain/entities/request/package_subscribe_request.dart';
import 'package:waseet/features/user/domain/entities/request/register_request.dart';
import 'package:waseet/features/user/domain/entities/request/update_profile_request.dart';
import 'package:waseet/features/user/domain/entities/subscription/my_subscription_entity.dart';
import 'package:waseet/features/user/domain/entities/subscription/subscription_entity.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class AuthenticationDataSource {
  AuthenticationDataSource({
    required ApiService apiService,
  }) : _apiService = apiService;
  final ApiService _apiService;

  Future<Resource<UserResponse>> login(LoginRequest request) async {
    try {
      final response = await _apiService.post(
        '/auth/login',
        data: request.toJson(),
      );

      if (response!['data'] == null) {
        final message = response['message'] as String;
        return Resource.error(
          response['message'] as String,
          null,
          response['errors'] as Map<String, dynamic>?,
        );
      }

      return Resource.success(
        UserResponse.fromMap(response as Map<String, dynamic>),
      );
    } on DioException catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    } catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<UserResponse>> register(RegisterRequest request) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/auth/register',
        data: request.toJson(),
      );

      if (response!['data'] == null) {
        final message = response['message'] as String;
        return Resource.error(
          response['message'] as String,
          null,
          response['errors'] as Map<String, dynamic>?,
        );
      }

      return Resource.success(UserResponse.fromMap(response));
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await _apiService.post<Map<String, dynamic>>(
        '/auth/logout',
      );
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Resource<UserResponse>> getUser() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/auth/me',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['data'] == null) {
        final message = response['message'] as String;
        return Resource.error(
          message,
          null,
          response['errors'] as Map<String, dynamic>?,
        );
      }

      return Resource.success(UserResponse.fromMap(response));
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  // get user by id
  Future<Resource<WassetProfileEntity>> getUserById(String userId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/auth/profile/$userId/show',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['data'] == null) {
        final message = response['message'] as String;
        return Resource.error(
          message,
          null,
          response['errors'] as Map<String, dynamic>?,
        );
      }

      return Resource.success(
        ProfileResponse.fromMap(response).data!.first.toEntity(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<UserResponse>> updateProfile(
    UpdateProfileRequest request,
  ) async {
    try {
      final response = await _apiService.put<Map<String, dynamic>>(
        request.isBroker
            ? '/auth/update-profile'
            : '/auth/update-customer-profile',
        data: request.toMap(),
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['data'] == null) {
        final message = response['message'] as String;
        return Resource.error(
          message,
          null,
          response['errors'] as Map<String, dynamic>?,
        );
      }

      return Resource.success(UserResponse.fromMap(response));
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<UserResponse>> updateProfileImage(
    File image,
    bool isBroker,
  ) async {
    try {
      return _apiService.post<Map<String, dynamic>>(
        isBroker
            ? '/auth/update-profile-logo'
            : '/auth/update-customer-profile-logo',
        data: dio.FormData.fromMap(
          {
            'profile_image': await dio.MultipartFile.fromFile(
              image.path,
              filename: image.path.split('/').last,
            ),
          },
        ),
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      ).then((response) {
        if (response!['data'] == null) {
          final message = response['message'] as String;
          return Resource.error(
            message,
            null,
            response['errors'] as Map<String, dynamic>?,
          );
        }

        return Resource.success(UserResponse.fromMap(response));
      });
    } on Exception catch (e) {
      log(e.toString());
      return Future.value(Resource.error(e.toString()));
    }
  }

  Future<Resource<SubscriptionEntity>> subscribeToPackage(
    PackageSubscribeRequest request,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/subscriptions/${request.packageId}',
        data: request.toJson(),
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['data'] == null) {
        final message = response['message'] as String;
        return Resource.error(
          message,
          null,
          response['errors'] as Map<String, dynamic>?,
        );
      }

      return Resource.success(
        SubscriptionModel.fromJson(response['data'] as Map<String, dynamic>)
            .toEntity(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<MySubscriptionEntity>?>> getMySubscriptions() async {
    try {
      // return Resource.success(
      //   dummyList,
      // );
      final response = await _apiService.get<Map<String, dynamic>>(
        '/subscriptions',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response == null) {
        return Resource.error('No data found');
      }

      final data = response['data'] as List<dynamic>;

      return Resource.success(
        data
            .map(
              (e) => MySubscriptionModel.fromJson(e as Map<String, dynamic>)
                  .toEntity(),
            )
            .toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<void> updateFcmToken(String fcmToken) async {
    try {
      await _apiService.post<Map<String, dynamic>>(
        '/auth/set-fcm-token',
        data: {
          'fcm_token': fcmToken,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Resource<NafathResponse>> authNafath(String nationalId) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/get-nafath-data',
        // data: {
        //   'nationalId': nationalId,
        // },
      );

      if (response!['data'] == null) {
        final message = response['message'] as String;
        return Resource.error(
          message,
          null,
          response['errors'] as Map<String, dynamic>?,
        );
      }

      return Resource.success(
        NafathResponse.fromMap(response['data'] as Map<String, dynamic>),
      );
    } on Exception catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}

class NafathResponse {
  NafathResponse({
    this.transId,
    this.random,
  });

  factory NafathResponse.fromMap(Map<String, dynamic> map) {
    return NafathResponse(
      transId: map['transId'] as String?,
      random: map['random'] as String?,
    );
  }

  final String? transId;
  final String? random;
}
