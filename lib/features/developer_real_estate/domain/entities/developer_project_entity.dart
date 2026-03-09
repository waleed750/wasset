class DeveloperProjectEntity {

  DeveloperProjectEntity({
    required this.id,
    required this.name,
    this.description,
    this.cover,
    this.images,
    this.city,
    this.neighborhood,
    this.mapUrl,
    this.priceMin,
    this.priceMax,
    this.unitStartingFrom,
    this.commissionPercentage,
    this.createdSince,
    this.contactPhone,
    this.developerId,
    this.developerName,
    this.developerLogo,
    this.developerDescription,
    this.visitingTimeFrom,
    this.visitingTimeTo,
    this.units,
    this.financingOptions,
  });
  final int id;
  final String name;
  final String? description;
  final String? cover;
  final List<String>? images;
  
  // Flattened location
  final String? city;
  final String? neighborhood;
  final String? mapUrl;
  
  // Flattened price_range
  final double? priceMin;
  final double? priceMax;
  final double? unitStartingFrom;
  
  final double? commissionPercentage;
  final String? createdSince;
  final String? contactPhone;
  
  // Flattened developer
  final int? developerId;
  final String? developerName;
  final String? developerLogo;
  final String? developerDescription;
  
  // Flattened visiting_times
  final String? visitingTimeFrom;
  final String? visitingTimeTo;
  
  // Keep minimal for MVP
  final List<dynamic>? units;
  final List<dynamic>? financingOptions;
}
