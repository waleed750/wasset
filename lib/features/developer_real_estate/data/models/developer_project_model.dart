import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';

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

String? _safeParseString(dynamic value) {
  if (value == null) return null;
  final parsed = value.toString().trim();
  return parsed.isEmpty ? null : parsed;
}

String? _extractImageUrl(dynamic value) {
  if (value == null) return null;
  if (value is String) return _safeParseString(value);
  if (value is Map<String, dynamic>) {
    for (final key in [
      'url',
      'full_url',
      'file',
      'path',
      'image',
      'cover',
      'project_cover',
      'main_image',
      'cover_image',
      'original_url',
      'preview_url',
      'src',
    ]) {
      final imageUrl = _extractImageUrl(value[key]);
      if (imageUrl != null) return imageUrl;
    }
    return null;
  }
  return _safeParseString(value);
}

List<String>? _parseImages(dynamic value) {
  if (value == null) return null;
  if (value is List) {
    final images = value.map(_extractImageUrl).whereType<String>().toList();
    return images.isEmpty ? null : images;
  }
  final imageUrl = _extractImageUrl(value);
  return imageUrl == null ? null : [imageUrl];
}

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
    // The list endpoint sends the main image as `project_cover`, while
    // details uses `cover`; keep both shapes mapped to the entity cover.
    final images = _parseImages(
      json['images'] ??
          json['media'] ??
          json['attachments'] ??
          json['attechments'],
    );
    final cover = _extractImageUrl(json['cover']) ??
        _extractImageUrl(json['project_cover']) ??
        _extractImageUrl(json['main_image']) ??
        _extractImageUrl(json['cover_image']) ??
        _extractImageUrl(json['image']) ??
        images?.first;

    return DeveloperProjectModel(
      id: _safeParseInt(json['id']) ?? 0,
      name: json['name'] as String,
      description: json['description'] as String?,
      cover: cover,
      images: images,

      // Flatten location
      city: location?['city'] as String?,
      neighborhood: location?['neighborhood'] as String?,
      mapUrl: location?['map_url'] as String?,

      // Flatten price_range with safe parsing
      priceMin: _safeParseDouble(priceRange?['min']),
      priceMax: _safeParseDouble(priceRange?['max']),
      unitStartingFrom: _safeParseDouble(priceRange?['unit_starting_from']),

      commissionPercentage: _safeParseDouble(json['commission_percentage']),
      createdSince: json['created_since'] as String?,
      contactPhone: json['contact_phone'] as String?,

      // Flatten developer with safe parsing
      developerId: _safeParseInt(developer?['id']),
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
