import 'package:waseet/features/user/data/models/home/neighborhood.model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class NeighborhoodResponse with BasePaginationResponse<NeighborhoodModel> {
  NeighborhoodResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: NeighborhoodModel.fromJson);
  }
}
