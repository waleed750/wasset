import 'package:waseet/features/tahalf/data/models/tahalf_model/tahalf_model.dart';
import 'package:waseet/res/response/base.response.dart';

class TahalfResponse with BaseResponse<TahalfModel> {
  TahalfResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: TahalfModel.fromJson);
    accessToken = json['access_token'] as String?;
  }
  String? accessToken;
}
