import 'package:waseet/features/user/data/models/wasset_user_model.dart';
import 'package:waseet/res/response/base.response.dart';

class UserResponse with BaseResponse<WassetUserModel> {
  UserResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: WassetUserModel.fromMap);
    accessToken = json['access_token'] as String?;
  }
  String? accessToken;
}
