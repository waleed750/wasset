import 'package:waseet/features/user/data/models/wasset_user/wasset_user/wasset_profile_model.dart';
import 'package:waseet/features/user/data/models/wasset_user_model.dart';
import 'package:waseet/res/response/base.response.dart';

class ProfileResponse with BaseResponse<WassetProfileModel> {
  ProfileResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: WassetProfileModel.fromJson);
  }
  String? accessToken;
}
