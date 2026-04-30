import 'package:waseet/features/developer_real_estate/domain/entities/developer_opportunity_request_entity.dart';

// Safe parsing helpers
double? _safeParseDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) {
    final parsed = double.tryParse(value);
    return parsed;
  }
  return null;
}

int? _safeParseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

List<String>? _safeParseStringList(dynamic value) {
  if (value == null) return null;
  if (value is List) {
    try {
      return value.map((e) => e.toString()).toList();
    } catch (_) {
      return null;
    }
  }
  if (value is String) return [value];
  return null;
}

bool? _safeParseBool(dynamic value) {
  if (value == null) return null;
  if (value is bool) return value;
  if (value is int) return value != 0;
  if (value is String) {
    return value.toLowerCase() == 'true' || value == '1';
  }
  return null;
}

String? _safeParseString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

// Model for developer info within request
class DeveloperInfoModel {

  DeveloperInfoModel({
    this.id,
    this.companyName,
    this.responsibleName,
    this.responsibleMobile,
    this.logo,
  });

  factory DeveloperInfoModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      return DeveloperInfoModel();
    }
    return DeveloperInfoModel(
      id: _safeParseInt(json['id']),
      companyName: _safeParseString(json['company_name']),
      responsibleName: _safeParseString(json['responsible_name']),
      responsibleMobile: _safeParseString(json['responsible_mobile']),
      logo: _safeParseString(json['logo']),
    );
  }
  final int? id;
  final String? companyName;
  final String? responsibleName;
  final String? responsibleMobile;
  final String? logo;

  DeveloperInfoEntity toEntity() {
    return DeveloperInfoEntity(
      id: id,
      companyName: companyName,
      responsibleName: responsibleName,
      responsibleMobile: responsibleMobile,
      logo: logo,
    );
  }
}

class DeveloperOpportunityRequestModel {

  DeveloperOpportunityRequestModel({
    required this.id,
    this.developerId,
    this.communicationRequestTypeId,
    this.communicationRequestType,
    this.opportunityType,
    this.cityId,
    this.neighborhoodId,
    this.locationUrl,
    this.description,
    this.commissionPercentage,
    this.communicationMethods,
    this.additionalIncentive,
    this.isActive,
    this.developer,
    this.city,
    this.neighborhood,
    this.createdAt,
    this.updatedAt,
  });

  factory DeveloperOpportunityRequestModel.fromJson(Map<String, dynamic> json) {
    return DeveloperOpportunityRequestModel(
      id: _safeParseInt(json['id']) ?? 0,
      developerId: _safeParseInt(json['developer_id']),
      communicationRequestTypeId: _safeParseInt(json['communication_request_type_id']),
      communicationRequestType: _safeParseString(json['communication_request_type']),
      opportunityType: _safeParseString(json['opportunity_type']),
      cityId: _safeParseInt(json['city_id']),
      neighborhoodId: _safeParseInt(json['neighborhood_id']),
      locationUrl: _safeParseString(json['location_url']),
      description: _safeParseString(json['description']),
      commissionPercentage: _safeParseDouble(json['commission_percentage']),
      communicationMethods: _safeParseStringList(json['communication_methods']),
      additionalIncentive: _safeParseString(json['additional_incentive']),
      isActive: _safeParseBool(json['is_active']),
      developer: DeveloperInfoModel.fromJson(json['developer'] as Map<String, dynamic>?),
      city: _safeParseString(json['city']),
      neighborhood: _safeParseString(json['neighborhood']),
      createdAt: _safeParseString(json['created_at']),
      updatedAt: _safeParseString(json['updated_at']),
    );
  }
  final int id;
  final int? developerId;
  final int? communicationRequestTypeId;
  final String? communicationRequestType;
  final String? opportunityType;
  final int? cityId;
  final int? neighborhoodId;
  final String? locationUrl;
  final String? description;
  final double? commissionPercentage;
  final List<String>? communicationMethods;
  final String? additionalIncentive;
  final bool? isActive;
  final DeveloperInfoModel? developer;
  final String? city;
  final String? neighborhood;
  final String? createdAt;
  final String? updatedAt;

  DeveloperOpportunityRequestEntity toEntity() {
    return DeveloperOpportunityRequestEntity(
      id: id,
      developerId: developerId,
      communicationRequestTypeId: communicationRequestTypeId,
      communicationRequestType: communicationRequestType,
      opportunityType: opportunityType,
      cityId: cityId,
      neighborhoodId: neighborhoodId,
      locationUrl: locationUrl,
      description: description,
      commissionPercentage: commissionPercentage,
      communicationMethods: communicationMethods,
      additionalIncentive: additionalIncentive,
      isActive: isActive,
      developer: developer?.toEntity(),
      city: city,
      neighborhood: neighborhood,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
