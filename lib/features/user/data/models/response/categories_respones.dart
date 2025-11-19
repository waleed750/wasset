import 'package:waseet/features/user/data/models/category_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class CategoriesResponse with BasePaginationResponse<CategoryModel> {
  CategoriesResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: CategoryModel.fromMap);
  }
}
