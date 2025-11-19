import 'package:waseet/features/user/data/models/home/slider_model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class SlidersResponse with BasePaginationResponse<SliderModel> {
  SlidersResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: SliderModel.fromJson);
  }
}
