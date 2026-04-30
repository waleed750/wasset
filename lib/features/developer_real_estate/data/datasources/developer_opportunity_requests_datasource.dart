import 'dart:developer';

import 'package:waseet/features/developer_real_estate/data/models/developer_opportunity_request_model.dart';
import 'package:waseet/features/developer_real_estate/data/models/developer_opportunity_requests_response_model.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_request_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_filter_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/paginated_result.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/resource.dart';
import 'package:waseet/res/shared_preferences.dart';

class DeveloperOpportunityRequestsDatasource {
  final ApiService _apiService;

  DeveloperOpportunityRequestsDatasource({required ApiService apiService})
      : _apiService = apiService;

  Future<Resource<PaginatedResult<DeveloperOpportunityRequestEntity>?>>
      getOpportunityRequests({
    int page = 1,
    int? cityId,
    String? opportunityType,
    int? communicationRequestTypeId,
    int? developerId,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        if (cityId != null) 'city_id': cityId,
        if (opportunityType != null && opportunityType.isNotEmpty)
          'opportunity_type': opportunityType,
        if (communicationRequestTypeId != null)
          'communication_request_type_id': communicationRequestTypeId,
        if (developerId != null) 'developer_id': developerId,
      };

      final response = await _apiService.get<Map<String, dynamic>>(
        '/developer-opportunity-requests',
        queryParameters: queryParams,
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}',
        },
      );

      if (response == null) {
        return Resource.error('No response from server');
      }

      final parsedResponse =
          DeveloperOpportunityRequestsResponseModel.fromJson(response);

      final entities = parsedResponse.data
          .map((model) => model.toEntity())
          .toList();

      final result = PaginatedResult<DeveloperOpportunityRequestEntity>(
        data: entities,
        currentPage: parsedResponse.currentPage ?? 1,
        lastPage: parsedResponse.lastPage ?? 1,
        total: parsedResponse.total,
        nextPageUrl: null,
      );

      return Resource.success(result);
    } catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<DeveloperOpportunityRequestEntity?>> getOpportunityRequestById(
    int id,
  ) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/developer-opportunity-requests/$id',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}',
        },
      );

      if (response == null) {
        return Resource.error('No response from server');
      }

      final parsedResponse =
          DeveloperOpportunityDetailResponseModel.fromJson(response);

      if (parsedResponse.data == null) {
        return Resource.error('Request not found');
      }

      return Resource.success(parsedResponse.data!.toEntity());
    } catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }

  Future<Resource<DeveloperOpportunityFiltersCollectionEntity?>>
      getAvailableFilters() async {
    try {
      // Fetch all filter endpoints in parallel
      final oppTypesResult = _apiService.get<Map<String, dynamic>>(
        '/developer-opportunity-requests/opportunity-types',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}',
        },
      );

      final commTypesResult = _apiService.get<Map<String, dynamic>>(
        '/developer-opportunity-requests/communication-request-types',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}',
        },
      );

      final developersResult = _apiService.get<Map<String, dynamic>>(
        '/developer-opportunity-requests/developers',
        headers: {
          'Authorization': 'Bearer ${wassetSharedPreferences.getToken()}',
        },
      );

      final results = await Future.wait([
        oppTypesResult,
        commTypesResult,
        developersResult,
      ]);

      final oppTypesResponse =
          DeveloperOpportunityFiltersResponseModel.fromOppTypes(
        results[0] ?? {},
      );
      final commTypesResponse =
          DeveloperOpportunityFiltersResponseModel.fromCommTypes(
        results[1] ?? {},
      );
      final developersResponse =
          DeveloperOpportunityFiltersResponseModel.fromDevelopers(
        results[2] ?? {},
      );

      final merged = oppTypesResponse
          .merge(commTypesResponse)
          .merge(developersResponse);

      final entity = DeveloperOpportunityFiltersCollectionEntity(
        opportunityTypes: merged.opportunityTypes
            .map((m) => DeveloperOpportunityFilterEntity(
              id: m.id,
              name: m.name,
            ))
            .toList(),
        communicationRequestTypes: merged.communicationRequestTypes
            .map((m) => DeveloperOpportunityFilterEntity(
              id: m.id,
              name: m.name,
            ))
            .toList(),
        developers: merged.developers
            .map((m) => DeveloperOpportunityFilterEntity(
              id: m.id,
              name: m.name,
            ))
            .toList(),
      );

      return Resource.success(entity);
    } catch (e) {
      log(e.toString());
      return Resource.error(e.toString());
    }
  }
}
