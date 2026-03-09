import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';

class DeveloperProjectModel {

  DeveloperProjectModel({
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

  factory DeveloperProjectModel.fromJson(Map<String, dynamic> json) {
    // Extract nested objects
    final location = json['location'] as Map<String, dynamic>?;
    final priceRange = json['price_range'] as Map<String, dynamic>?;
    final developer = json['developer'] as Map<String, dynamic>?;
    final visitingTimes = json['visiting_times'] as Map<String, dynamic>?;
    
    // Parse images list safely
    List<String>? images;
    if (json['images'] != null) {
      images = (json['images'] as List)
          .map((e) => e.toString())
          .toList();
    }

    return DeveloperProjectModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String?,
      cover: json['cover'] as String?,
      images: images,
      
      // Flatten location
      city: location?['city'] as String?,
      neighborhood: location?['neighborhood'] as String?,
      mapUrl: location?['map_url'] as String?,
      
      // Flatten price_range
      priceMin: (priceRange?['min'] as num?)?.toDouble(),
      priceMax: (priceRange?['max'] as num?)?.toDouble(),
      unitStartingFrom: (priceRange?['unit_starting_from'] as num?)?.toDouble(),
      
      commissionPercentage: (json['commission_percentage'] as num?)?.toDouble(),
      createdSince: json['created_since'] as String?,
      contactPhone: json['contact_phone'] as String?,
      
      // Flatten developer
      developerId: developer?['id'] as int?,
      developerName: developer?['name'] as String?,
      developerLogo: developer?['logo'] as String?,
      developerDescription: developer?['description'] as String?,
      
      // Flatten visiting_times
      visitingTimeFrom: visitingTimes?['from'] as String?,
      visitingTimeTo: visitingTimes?['to'] as String?,
      
      units: json['units'] as List<dynamic>?,
      financingOptions: json['financing_options'] as List<dynamic>?,
    );
  }
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

  DeveloperProjectEntity toEntity() {
    return DeveloperProjectEntity(
      id: id,
      name: name,
      description: description,
      cover: cover,
      images: images,
      city: city,
      neighborhood: neighborhood,
      mapUrl: mapUrl,
      priceMin: priceMin,
      priceMax: priceMax,
      unitStartingFrom: unitStartingFrom,
      commissionPercentage: commissionPercentage,
      createdSince: createdSince,
      contactPhone: contactPhone,
      developerId: developerId,
      developerName: developerName,
      developerLogo: developerLogo,
      developerDescription: developerDescription,
      visitingTimeFrom: visitingTimeFrom,
      visitingTimeTo: visitingTimeTo,
      units: units,
      financingOptions: financingOptions,
    );
  }
}
