import 'dart:developer';

import 'package:waseet/features/tahalf/data/models/response/Tahalf_response.dart';
import 'package:waseet/features/tahalf/domain/entities/request/attach_to_tahalf_request.dart';
import 'package:waseet/features/tahalf/domain/entities/request/create_tahalf_request.dart';
import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/enums/tahalf_type.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class TahalfDataSource {
  TahalfDataSource({
    required ApiService apiService,
  }) : _apiService = apiService;
  final ApiService _apiService;

  Future<Resource<String>> createTahalf(
    CreateTahalfRequest request,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/alliances',
        data: request.tahalfType == TahalfType.private.name
            ? request.toMapPrivate()
            : request.toMapPublic(),
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

  Future<Resource<String>> updateTahalf(
    CreateTahalfRequest request,
    int id,
  ) async {
    try {
      final response = await _apiService.put<Map<String, dynamic>>(
        '/alliances/$id',
        data: request.tahalfType == TahalfType.private.name
            ? request.toMapPrivate()
            : request.toMapPublic(),
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

  Future<Resource<List<TahalfEntity>?>> getTahalfat() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/alliances',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responseTahalf = TahalfResponse.fromMap(response!);

      if (responseTahalf.data == null) {
        final message = responseTahalf.message!;
        return Resource.error(
          message,
          null,
          responseTahalf.errors,
        );
      }
      return Resource.success(
        responseTahalf.data!.map((e) => e.toEntity()).toList(),
      );
    } catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> attachToTahalf(
    AttachToTahalfRequest request,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/alliances/${request.tahalfID}/attach-user/${request.userId}',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
        queryParameters: {'password': request.password},
      );
      if (response!['message'] == 'تم إرفاق المستخدم بالتحالف بنجاح') {
        return Resource.success(response['message'] as String);
      }
      final message = response['error'] as String;
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

  Future<Resource<String>> deleteTahalf(int tahalfId) async {
    try {
      final response = await _apiService.delete<Map<String, dynamic>>(
        '/alliances/$tahalfId',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['message'] != 'تم حذف التحالف بنجاح') {
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

  Future<Resource<String>> exitFromTahalf(
    AttachToTahalfRequest request,
  ) async {
    try {
      final response = await _apiService.delete<Map<String, dynamic>>(
        '/alliances/${request.tahalfID}/remove-user/${request.userId}',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );
      if (response!['message'] != 'تم إزالة المستخدم من التحالف بنجاح') {
        final message = response['error'] as String;
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
}
