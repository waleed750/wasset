import 'package:waseet/features/developer_real_estate/domain/entities/developer_info_entity.dart';

// Safe numeric parsing helper
int? _safeParseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class DeveloperInfoModel {
  const DeveloperInfoModel({
    required this.id,
    required this.name,
    this.responsibleName,
    this.responsibleMobile,
    this.logo,
  });

  factory DeveloperInfoModel.fromJson(Map<String, dynamic> json) {
    return DeveloperInfoModel(
      id: _safeParseInt(json['id']) ?? 0,
      name: json['name'] as String,
      responsibleName: json['responsible_name'] as String?,
      responsibleMobile: json['responsible_mobile'] as String?,
      logo: json['logo'] as String?,
    );
  }

  final int id;
  final String name;
  final String? responsibleName;
  final String? responsibleMobile;
  final String? logo;

  DeveloperInfoEntity toEntity() {
    return DeveloperInfoEntity(
      id: id,
      name: name,
      responsibleName: responsibleName,
      responsibleMobile: responsibleMobile,
      logo: logo,
    );
  }
}
