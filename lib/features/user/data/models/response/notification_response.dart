import 'package:waseet/features/user/data/models/notification.model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class NotificationResponse with BasePaginationResponse<NotificationModel> {
  NotificationResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: NotificationModel.fromMap);
    accessToken = json['access_token'] as String?;
  }
  String? accessToken;
}
