import 'package:waseet/features/developer_real_estate/data/models/developer_category_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class DeveloperCategoryResponse with BasePaginationResponse<DeveloperCategoryModel> {
  DeveloperCategoryResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: DeveloperCategoryModel.fromJson);
  }
}
