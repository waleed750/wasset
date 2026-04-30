import 'package:waseet/features/developer_real_estate/domain/entities/developer_category_entity.dart';

// Safe numeric parsing helper
int? _safeParseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

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
      projectCount: _safeParseInt(json['project_count']),
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
