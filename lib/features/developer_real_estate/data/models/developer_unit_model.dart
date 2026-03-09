import 'package:waseet/features/developer_real_estate/domain/entities/developer_unit_entity.dart';

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
  });

  factory DeveloperUnitModel.fromJson(Map<String, dynamic> json) {
    // Extract nested objects
    final unitType = json['unit_type'] as Map<String, dynamic>?;
    final project = json['project'] as Map<String, dynamic>?;
    final projectDeveloper = project?['developer'] as Map<String, dynamic>?;
    
    // Parse images list safely
    List<String>? images;
    if (json['images'] != null) {
      images = (json['images'] as List)
          .map((e) => e.toString())
          .toList();
    }

    return DeveloperUnitModel(
      id: json['id'] as int,
      name: json['name'] as String,
      unitCode: json['unit_code'] as String?,
      area: (json['area'] as num?)?.toDouble(),
      price: (json['price'] as num?)?.toDouble(),
      
      // Flatten unit_type
      unitTypeKey: unitType?['key'] as String?,
      unitTypeLabel: unitType?['label'] as String?,
      
      roomsCount: json['rooms_count'] as int?,
      bathroomsCount: json['bathrooms_count'] as int?,
      hallsCount: json['halls_count'] as int?,
      others: json['others'] as String?,
      availabilityStatus: json['availability_status'] as String?,
      description: json['description'] as String?,
      cover: json['cover'] as String?,
      images: images,
      
      // Flatten project info
      projectId: project?['id'] as int?,
      projectName: project?['name'] as String?,
      projectCity: project?['city'] as String?,
      projectNeighborhood: project?['neighborhood'] as String?,
      projectLocationUrl: project?['location_url'] as String?,
      projectContactPhone: project?['contact_phone'] as String?,
      projectCommission: (project?['commission'] as num?)?.toDouble(),
      
      // Flatten project.developer
      projectDeveloperId: projectDeveloper?['id'] as int?,
      projectDeveloperName: projectDeveloper?['name'] as String?,
      projectDeveloperLogo: projectDeveloper?['logo'] as String?,
      
      financingOptions: json['financing_options'] as List<dynamic>?,
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
    );
  }
}
