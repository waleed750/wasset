import 'package:waseet/features/brokers/data/models/fav_broker_model/fav_broker_model.dart';
import 'package:waseet/features/user/data/models/wasset_user/wasset_user/wasset_profile_model.dart';
import 'package:waseet/res/response/base.response.dart';

class BrokersResponse with BaseResponse<WassetProfileModel> {
  BrokersResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: WassetProfileModel.fromJson);
    accessToken = json['access_token'] as String?;
  }
  String? accessToken;
}

class FavBrokersResponse with BaseResponse<FavBrokerModel> {
  FavBrokersResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: FavBrokerModel.fromMap);
    accessToken = json['access_token'] as String?;
  }
  String? accessToken;
}
