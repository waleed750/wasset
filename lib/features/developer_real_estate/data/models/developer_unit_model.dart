import 'package:waseet/features/developer_real_estate/data/models/developer_info_model.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';

// Safe numeric parsing helpers
int? _safeParseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

double? _safeParseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}

class DeveloperUnitModel {

  DeveloperUnitModel({
    required this.id,
    required this.name,
    this.unitCode,
    this.area,
    this.price,
    this.unitTypeKey,
    this.unitTypeLabel,
    this.roomsCount,
    this.bathroomsCount,
    this.hallsCount,
    this.others,
    this.availabilityStatus,
    this.description,
    this.cover,
    this.images,
    this.projectId,
    this.projectName,
    this.projectCity,
    this.projectNeighborhood,
    this.projectLocationUrl,
    this.projectContactPhone,
    this.projectCommission,
    this.projectDeveloperId,
    this.projectDeveloperName,
    this.projectDeveloperLogo,
    this.financingOptions,
    this.developerInfo,
  });

  factory DeveloperUnitModel.fromJson(Map<String, dynamic> json) {
    // Extract nested objects
    final unitType = json['unit_type'] as Map<String, dynamic>?;
    final project = json['project'] as Map<String, dynamic>?;
    final projectDeveloper = project?['developer'] as Map<String, dynamic>?;
    final developerInfo = projectDeveloper != null
        ? DeveloperInfoModel.fromJson(projectDeveloper)
        : null;
    
    // Parse images list safely
    List<String>? images;
    if (json['images'] != null) {
      images = (json['images'] as List)
          .map((e) => e.toString())
          .toList();
    }

    return DeveloperUnitModel(
      id: _safeParseInt(json['id']) ?? 0,
      name: json['name'] as String,
      unitCode: json['unit_code'] as String?,
      area: _safeParseDouble(json['area']),
      price: _safeParseDouble(json['price']),
      
      // Flatten unit_type
      unitTypeKey: unitType?['key'] as String?,
      unitTypeLabel: unitType?['label'] as String?,
      
      roomsCount: _safeParseInt(json['rooms_count']),
      bathroomsCount: _safeParseInt(json['bathrooms_count']),
      hallsCount: _safeParseInt(json['halls_count']),
      others: json['others'] as String?,
      availabilityStatus: json['availability_status'] as String?,
      description: json['description'] as String?,
      cover: json['cover'] as String?,
      images: images,
      
      // Flatten project info
      projectId: _safeParseInt(project?['id']),
      projectName: project?['name'] as String?,
      projectCity: project?['city'] as String?,
      projectNeighborhood: project?['neighborhood'] as String?,
      projectLocationUrl: project?['location_url'] as String?,
      projectContactPhone: project?['contact_phone'] as String?,
      projectCommission: _safeParseDouble(project?['commission']),
      
      // Flatten project.developer
      projectDeveloperId: _safeParseInt(projectDeveloper?['id']),
      projectDeveloperName: projectDeveloper?['name'] as String?,
      projectDeveloperLogo: projectDeveloper?['logo'] as String?,
      
      financingOptions: json['financing_options'] as List<dynamic>?,
      developerInfo: developerInfo,
    );
  }
  final int id;
  final String name;
  final String? unitCode;
  final double? area;
  final double? price;
  
  // Flattened unit_type
  final String? unitTypeKey;
  final String? unitTypeLabel;
  
  final int? roomsCount;
  final int? bathroomsCount;
  final int? hallsCount;
  final String? others;
  final String? availabilityStatus;
  final String? description;
  final String? cover;
  final List<String>? images;
  
  // Flattened project info
  final int? projectId;
  final String? projectName;
  final String? projectCity;
  final String? projectNeighborhood;
  final String? projectLocationUrl;
  final String? projectContactPhone;
  final double? projectCommission;
  
  // Flattened project.developer
  final int? projectDeveloperId;
  final String? projectDeveloperName;
  final String? projectDeveloperLogo;
  
  final List<dynamic>? financingOptions;
  final DeveloperInfoModel? developerInfo;

  DeveloperUnitEntity toEntity() {
    return DeveloperUnitEntity(
      id: id,
      name: name,
      unitCode: unitCode,
      area: area,
      price: price,
      unitTypeKey: unitTypeKey,
      unitTypeLabel: unitTypeLabel,
      roomsCount: roomsCount,
      bathroomsCount: bathroomsCount,
      hallsCount: hallsCount,
      others: others,
      availabilityStatus: availabilityStatus,
      description: description,
      cover: cover,
      images: images,
      projectId: projectId,
      projectName: projectName,
      projectCity: projectCity,
      projectNeighborhood: projectNeighborhood,
      projectLocationUrl: projectLocationUrl,
      projectContactPhone: projectContactPhone,
      projectCommission: projectCommission,
      projectDeveloperId: projectDeveloperId,
      projectDeveloperName: projectDeveloperName,
      projectDeveloperLogo: projectDeveloperLogo,
      financingOptions: financingOptions,
      developerInfo: developerInfo?.toEntity(),
    );
  }
}
