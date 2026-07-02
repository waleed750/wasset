import 'package:waseet/features/developer_real_estate/data/datasources/developer_real_estate_datasource.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_category_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_city_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/paginated_result.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/request/developer_unit_inquiry_request.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_real_estate_repository.dart';
import 'package:waseet/res/resource.dart';

class DeveloperRealEstateRepositoryImpl extends DeveloperRealEstateRepository {
  DeveloperRealEstateRepositoryImpl({
    required DeveloperRealEstateDatasource datasource,
  }) : _datasource = datasource;

  final DeveloperRealEstateDatasource _datasource;

  @override
  Future<Resource<List<DeveloperCategoryEntity>?>> getCategories() {
    return _datasource.getCategories();
  }

  @override
  Future<Resource<List<DeveloperCityEntity>?>> getCities() {
    return _datasource.getCities();
  }

  @override
  Future<Resource<PaginatedResult<DeveloperProjectEntity>?>> getProjects({
    int page = 1,
    String? category,
    int? cityId,
  }) {
    return _datasource.getProjects(
      page: page,
      category: category,
      cityId: cityId,
    );
  }

  @override
  Future<Resource<DeveloperProjectEntity?>> getProjectById(int id) {
    return _datasource.getProjectById(id);
  }

  @override
  Future<Resource<DeveloperUnitEntity?>> getUnitById(int id) {
    return _datasource.getUnitById(id);
  }

  @override
  Future<Resource<String>> createPotentialCustomer(
    DeveloperUnitInquiryRequest request,
  ) {
    return _datasource.createPotentialCustomer(request);
  }
}
