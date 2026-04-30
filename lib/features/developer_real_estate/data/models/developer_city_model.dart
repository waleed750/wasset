import 'package:waseet/features/developer_real_estate/domain/entities/developer_city_entity.dart';

// Safe numeric parsing helper
int? _safeParseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class DeveloperCityModel {
  DeveloperCityModel({
    required this.id,
    required this.name,
  });

  factory DeveloperCityModel.fromJson(Map<String, dynamic> json) {
    return DeveloperCityModel(
      id: _safeParseInt(json['city_id']) ?? 0,
      name: json['label'] as String? ?? 'مدينة',
    );
  }

  final int id;
  final String name;

  DeveloperCityEntity toEntity() {
    return DeveloperCityEntity(
      id: id,
      name: name,
    );
  }
}
