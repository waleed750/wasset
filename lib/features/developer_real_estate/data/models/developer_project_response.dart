import 'package:waseet/features/developer_real_estate/data/models/developer_project_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class DeveloperProjectResponse with BasePaginationResponse<DeveloperProjectModel> {
  DeveloperProjectResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: DeveloperProjectModel.fromJson);
  }
}
