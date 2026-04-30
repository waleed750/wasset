class DeveloperOpportunityRequestEntity {

  DeveloperOpportunityRequestEntity({
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
  final DeveloperInfoEntity? developer;
  final String? city;
  final String? neighborhood;
  final String? createdAt;
  final String? updatedAt;
}

class DeveloperInfoEntity {

  DeveloperInfoEntity({
    this.id,
    this.companyName,
    this.responsibleName,
    this.responsibleMobile,
    this.logo,
  });
  final int? id;
  final String? companyName;
  final String? responsibleName;
  final String? responsibleMobile;
  final String? logo;
}
