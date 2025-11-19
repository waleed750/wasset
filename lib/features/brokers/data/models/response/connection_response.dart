import 'package:waseet/features/brokers/data/models/connection_request_model.dart';
import 'package:waseet/res/response/base.response.dart';

class ConnectionResponse with BaseResponse<ConnectionRequestModel> {
  ConnectionResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: ConnectionRequestModel.fromMap);
    accessToken = json['access_token'] as String?;
  }
  String? accessToken;
}
