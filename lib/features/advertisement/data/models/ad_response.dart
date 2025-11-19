import 'package:waseet/features/advertisement/data/models/ad_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class AdResponse with BasePaginationResponse<AdModel> {
  AdResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: AdModel.fromJson);
  }
}
