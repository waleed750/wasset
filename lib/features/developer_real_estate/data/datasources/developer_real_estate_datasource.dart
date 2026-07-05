import 'package:waseet/features/developer_real_estate/data/models/developer_category_response.dart';
import 'package:waseet/features/developer_real_estate/data/models/developer_city_response.dart';
import 'package:waseet/features/developer_real_estate/data/models/developer_project_details_response.dart';
import 'package:waseet/features/developer_real_estate/data/models/developer_project_response.dart';
import 'package:waseet/features/developer_real_estate/data/models/developer_unit_response.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_category_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_city_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/paginated_result.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/request/developer_unit_inquiry_request.dart';
import 'package:waseet/res/api_service.dart';
import 'package:waseet/res/resource.dart';

class DeveloperRealEstateDatasource {
  DeveloperRealEstateDatasource({required ApiService apiService})
      : _apiService = apiService;

  final ApiService _apiService;

  Future<Resource<List<DeveloperCategoryEntity>?>> getCategories() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/developer-projects/categories',
      );
      final categoryResponse = DeveloperCategoryResponse.fromMap(response!);
      if (categoryResponse.data != null) {
        return Resource.success(
          categoryResponse.data!.map((e) => e.toEntity()).toList(),
        );
      }
      return Resource.error(
        categoryResponse.message ?? 'error',
        null,
        categoryResponse.errors,
      );
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<List<DeveloperCityEntity>?>> getCities() async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/developer-projects/city-categories',
      );
      final cityResponse = DeveloperCityResponse.fromMap(response!);
      if (cityResponse.data != null) {
        return Resource.success(
          cityResponse.data!.map((e) => e.toEntity()).toList(),
        );
      }
      return Resource.error(
        cityResponse.message ?? 'error',
        null,
        cityResponse.errors,
      );
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<PaginatedResult<DeveloperProjectEntity>?>> getProjects({
    int page = 1,
    String? category,
    int? cityId,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        if (category != null && category.isNotEmpty) 'category': category,
        if (cityId != null) 'city_id': cityId,
      };

      final response = await _apiService.get<Map<String, dynamic>>(
        '/developer-projects',
        queryParameters: queryParams,
      );

      final projectResponse = DeveloperProjectResponse.fromMap(response!);
      if (projectResponse.data != null) {
        // Extract pagination metadata from BasePaginationResponse
        final result = PaginatedResult<DeveloperProjectEntity>(
          data: projectResponse.data!.map((e) => e.toEntity()).toList(),
          currentPage: projectResponse.currentPage ?? 1,
          lastPage: projectResponse.lastPage ?? 1,
          total: projectResponse.total,
          nextPageUrl: projectResponse.nextPageUrl,
        );
        return Resource.success(result);
      }
      return Resource.error(
        projectResponse.message ?? 'error',
        null,
        projectResponse.errors,
      );
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<DeveloperProjectEntity?>> getProjectById(int id) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/developer-projects/$id',
      );
      // Use dedicated single-object response, NOT paginated response
      final projectResponse =
          DeveloperProjectDetailsResponse.fromMap(response!);
      if (projectResponse.data != null) {
        return Resource.success(projectResponse.data!.toEntity());
      }
      return Resource.error(projectResponse.message ?? 'error');
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<DeveloperUnitEntity?>> getUnitById(int id) async {
    try {
      final response = await _apiService.get<Map<String, dynamic>>(
        '/developer-units/$id',
      );
      final unitResponse = DeveloperUnitResponse.fromMap(response!);
      if (unitResponse.data != null) {
        return Resource.success(unitResponse.data!.toEntity());
      }
      return Resource.error(unitResponse.message ?? 'error');
    } catch (e) {
      return Resource.error(e.toString());
    }
  }

  Future<Resource<String>> createPotentialCustomer(
    int unitId,
    DeveloperUnitInquiryRequest request,
  ) async {
    try {
      final response = await _apiService.post<Map<String, dynamic>>(
        '/developers/units/$unitId/potential-customers',
        data: request.toJson(),
      );

      if (response == null) {
        return Resource.error('تعذر إرسال بيانات العميل');
      }

      final errors = response['errors'];
      if (errors is Map && errors.isNotEmpty) {
        return Resource.error(
          response['message']?.toString() ?? 'تحقق من بيانات العميل',
          null,
          Map<String, dynamic>.from(errors),
        );
      }

      if (response['error'] != null) {
        return Resource.error(response['error'].toString());
      }

      return Resource.success(
        response['message']?.toString() ?? 'تم إرسال بيانات العميل بنجاح',
      );
    } catch (e) {
      return Resource.error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}
