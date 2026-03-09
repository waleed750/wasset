class DeveloperUnitEntity {

  DeveloperUnitEntity({
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
}
