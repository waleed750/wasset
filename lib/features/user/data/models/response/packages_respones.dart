import 'package:waseet/features/user/data/models/packages_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class PackagesResponse with BasePaginationResponse<PackagesModel> {
  PackagesResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: PackagesModel.fromMap);
  }
}
