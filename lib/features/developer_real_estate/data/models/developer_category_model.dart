import 'package:waseet/features/developer_real_estate/domain/entities/developer_category_entity.dart';

class DeveloperCategoryModel {

  DeveloperCategoryModel({
    required this.key,
    required this.label,
    this.projectCount,
  });

  factory DeveloperCategoryModel.fromJson(Map<String, dynamic> json) {
    return DeveloperCategoryModel(
      key: json['key'] as String,
      label: json['label'] as String,
      projectCount: json['project_count'] as int?,
    );
  }
  final String key;
  final String label;
  final int? projectCount;

  DeveloperCategoryEntity toEntity() {
    return DeveloperCategoryEntity(
      key: key,
      label: label,
      projectCount: projectCount,
    );
  }
}
