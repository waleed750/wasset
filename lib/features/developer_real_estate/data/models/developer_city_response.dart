import 'package:waseet/features/developer_real_estate/data/models/developer_city_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class DeveloperCityResponse with BasePaginationResponse<DeveloperCityModel> {
  DeveloperCityResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: DeveloperCityModel.fromJson);
  }
}
