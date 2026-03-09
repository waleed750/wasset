import 'package:waseet/features/developer_real_estate/data/models/developer_unit_model.dart';

class DeveloperUnitResponse {

  DeveloperUnitResponse.fromMap(Map<String, dynamic> json)
      : status = json['status'] as int?,
        message = json['message'] as String?,
        data = json['data'] != null 
            ? DeveloperUnitModel.fromJson(json['data'] as Map<String, dynamic>)
            : null;
  final int? status;
  final String? message;
  final DeveloperUnitModel? data;
}
