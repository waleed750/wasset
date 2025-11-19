import 'package:waseet/features/user/data/models/home/cities_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class CitiesResponse with BasePaginationResponse<CitiesModel> {
  CitiesResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: CitiesModel.fromJson);
  }
}
