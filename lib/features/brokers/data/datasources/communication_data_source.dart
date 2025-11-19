import 'dart:developer';

import 'package:waseet/features/brokers/data/models/response/connection_response.dart';
import 'package:waseet/features/brokers/domain/entities/chat_and_details_entity.dart';
import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/brokers/domain/entities/request/connection_request.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class CommunicationDataSource {
  CommunicationDataSource({
    required ApiService apiService,
  }) : _apiService = apiService;
  final ApiService _apiService;

  Future<Resource<String>> createRequest(
    ConnectionRequest request,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/communication-requests',
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

      return Resource.success(response['message'] as String);
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> updateRequest(
    ConnectionRequest request,
    int id,
  ) async {
    try {
      final response = await _apiService.put<Map<String, dynamic>>(
        '/communication-requests/$id',
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

      return Resource.success(response['message'] as String);
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> deleteRequest(int id) async {
    try {
      final response = await _apiService.delete<Map<String, dynamic>>(
        '/communication-requests/$id',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['message'] != 'CommunicationRequest deleted successfully') {
        final message = response['message'] as String;
        return Resource.error(
          message,
        );
      }
      return Resource.success(response['message'] as String);
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<ConnectionRequestEntity>?>> getRequests({
    int? userID,
    String? date,
  }) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/communication-requests',
        queryParameters: {
          if (userID != null) 'filter[user_id]': userID,
          if (date != null) 'filter[created_at]': date,
        },
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responseRequest = ConnectionResponse.fromMap(response!);

      if (responseRequest.data == null) {
        final message = responseRequest.message!;
        return Resource.error(
          message,
          null,
          responseRequest.errors,
        );
      }
      return Resource.success(
        responseRequest.data?.map((e) => e.toEntity()).toList(),
      );
    } catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<ConnectionRequestEntity>?>> getFavRequests() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/users/communication-requests/favorites',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );
      final responseRequest = ConnectionResponse.fromMap(response!);

      if (responseRequest.data == null) {
        final message = responseRequest.message!;
        return Resource.error(
          message,
          null,
          responseRequest.errors,
        );
      }
      return Resource.success(
        responseRequest.data?.map((e) => e.toEntity()).toList(),
      );
    } catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> addFavRequest(int id) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/users/communication-requests/$id/favorite',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['message'] !=
          'communicationRequest added to favorites successfully') {
        final message = response['message'] as String;
        return Resource.error(
          message,
        );
      }
      //TODO : Fix
      return Resource.success(
        'تمت اضافة الطلب للمفضلة',
//response['message'] as String
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> removeFavRequest(int id) async {
    try {
      final response = await _apiService.delete<Map<String, dynamic>>(
        '/users/communication-requests/$id/favorite',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['message'] !=
          'CommunicationRequest removed from favorites successfully') {
        final message = response['message'] as String;
        return Resource.error(
          message,
        );
      }
      //TODO : fix
      return Resource.success(
        'تم حذف الطلب من المفضلة',
        //response['message'] as String
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<ChatAndDetailsEntity>> acceptRequest(int id) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/chats/$id/messages',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['chat'] == null) {
        final message = response['message'] as String;
        return Resource.error(
          message,
          null,
          response['errors'] as Map<String, dynamic>?,
        );
      }

      return Resource.success(
        ChatAndDetailsEntity.fromMap(response),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }
}
