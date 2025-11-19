import 'dart:developer';
import 'package:waseet/features/user/data/models/response/complaint_response.dart';
import 'package:waseet/features/user/domain/entities/complaint_entity.dart';
import 'package:waseet/features/user/domain/entities/request/complaint_request.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class ComplaintDataSource {
  const ComplaintDataSource({required ApiService apiService})
      : _apiService = apiService;

  final ApiService _apiService;

  Future<Resource<List<ComplaintEntity>?>> getComplaints(int userId) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/complaints?filter[created_by]=$userId',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      final responseComplaints = ComplaintsResponse.fromMap(response!);

      if (responseComplaints.data == null) {
        final message = responseComplaints.message!;
        return Resource.error(
          message,
          null,
          responseComplaints.errors,
        );
      }
      return Resource.success(
        responseComplaints.data!.map((e) => e.toEntity()).toList(),
      );
    } on Exception catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> createComplaints(
    ComplaintRequest request,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/complaints',
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

  Future<Resource<String>> updateComplaints(
    ComplaintRequest request,
    int id,
  ) async {
    try {
      final response = await _apiService.put<Map<String, dynamic>>(
        '/alliances/$id',
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

  Future<Resource<String>> deleteComplaints(int tahalfId) async {
    try {
      final response = await _apiService.delete<Map<String, dynamic>>(
        '/alliances/$tahalfId',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}}',
        },
      );

      if (response!['message'] != 'complaint has been deleted successfly') {
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
}
