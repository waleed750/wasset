import 'package:waseet/features/user/data/models/complaint.model.dart';
import 'package:waseet/res/response/base_pagination.response.dart';

class ComplaintsResponse with BasePaginationResponse<Complaint> {
  ComplaintsResponse.fromMap(Map<String, dynamic> json) {
    super.fromJson(json, builder: Complaint.fromJson);
    accessToken = json['access_token'] as String?;
  }
  String? accessToken;
}
