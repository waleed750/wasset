import 'package:waseet/features/developer_real_estate/data/models/developer_project_model.dart';

class DeveloperProjectDetailsResponse {

  DeveloperProjectDetailsResponse.fromMap(Map<String, dynamic> json)
      : status = json['status'] as int?,
        message = json['message'] as String?,
        data = json['data'] != null 
            ? DeveloperProjectModel.fromJson(json['data'] as Map<String, dynamic>)
            : null;
  final int? status;
  final String? message;
  final DeveloperProjectModel? data;
}
