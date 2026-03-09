import 'package:waseet/features/developer_real_estate/domain/entities/developer_category_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/paginated_result.dart';
import 'package:waseet/res/resource.dart';

abstract class DeveloperRealEstateRepository {
  Future<Resource<List<DeveloperCategoryEntity>?>> getCategories();
  
  Future<Resource<PaginatedResult<DeveloperProjectEntity>?>> getProjects({
    int page = 1,
    String? category,
  });
  
  Future<Resource<DeveloperProjectEntity?>> getProjectById(int id);
  
  Future<Resource<DeveloperUnitEntity?>> getUnitById(int id);
}
