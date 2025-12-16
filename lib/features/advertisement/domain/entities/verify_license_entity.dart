class VerifyLocationEntity {

  VerifyLocationEntity({
    this.region,
    this.regionCode,
    this.city,
    this.cityCode,
    this.district,
    this.districtCode,
    this.street,
    this.postalCode,
    this.buildingNumber,
    this.additionalNumber,
    this.longitude,
    this.latitude,
    this.districtId,
    this.cityId,
    this.regionId,
  });
  final String? region;
  final String? regionCode;
  final String? city;
  final String? cityCode;
  final String? district;
  final String? districtCode;
  final String? street;
  final String? postalCode;
  final String? buildingNumber;
  final String? additionalNumber;
  final String? longitude;
  final String? latitude;
  final String? districtId;
  final String? cityId;
  final String? regionId;
}

class VerifyBordersEntity {

  VerifyBordersEntity({
    this.northLimitName,
    this.northLimitDescription,
    this.northLimitLengthChar,
    this.eastLimitName,
    this.eastLimitDescription,
    this.eastLimitLengthChar,
    this.westLimitName,
    this.westLimitDescription,
    this.westLimitLengthChar,
    this.southLimitName,
    this.southLimitDescription,
    this.southLimitLengthChar,
  });
  final String? northLimitName;
  final String? northLimitDescription;
  final String? northLimitLengthChar;
  final String? eastLimitName;
  final String? eastLimitDescription;
  final String? eastLimitLengthChar;
  final String? westLimitName;
  final String? westLimitDescription;
  final String? westLimitLengthChar;
  final String? southLimitName;
  final String? southLimitDescription;
  final String? southLimitLengthChar;
}

class VerifyLicenseEntity {

  VerifyLicenseEntity({
    this.advertiserId,
    this.adLicenseNumber,
    this.deedNumber,
    this.advertiserName,
    this.responsibleEmployeeName,
    this.responsibleEmployeePhoneNumber,
    this.phoneNumber,
    this.brokerageAndMarketingLicenseNumber,
    this.isConstrained,
    this.isPawned,
    this.isHalted,
    this.isTestment,
    this.rerConstraints,
    this.streetWidth,
    this.propertyArea,
    this.propertyPrice,
    this.landTotalPrice,
    this.landTotalAnnualRent,
    this.numberOfRooms,
    this.propertyType,
    this.propertyAge,
    this.advertisementType,
    this.location,
    this.propertyFace,
    this.planNumber,
    this.landNumber,
    this.obligationsOnTheProperty,
    this.guaranteesAndTheirDuration,
    this.complianceWithTheSaudiBuildingCode,
    this.channels,
    this.propertyUsages,
    this.mainLandUseTypeName,
    this.redZoneTypeName,
    this.propertyUtilities,
    this.creationDate,
    this.endDate,
    this.adLicenseUrl,
    this.adSource,
    this.titleDeedTypeName,
    this.locationDescriptionOnMOJDeed,
    this.notes,
    this.borders,
    this.rerBorders,
    this.ownershipTransferFeeType,
  });
  final String? advertiserId;
  final String? adLicenseNumber;
  final String? deedNumber;
  final String? advertiserName;
  final String? responsibleEmployeeName;
  final String? responsibleEmployeePhoneNumber;
  final String? phoneNumber;
  final String? brokerageAndMarketingLicenseNumber;
  final bool? isConstrained;
  final bool? isPawned;
  final bool? isHalted;
  final bool? isTestment;
  final dynamic rerConstraints;
  final num? streetWidth;
  final num? propertyArea;
  final num? propertyPrice;
  final num? landTotalPrice;
  final num? landTotalAnnualRent;
  final int? numberOfRooms;
  final String? propertyType;
  final String? propertyAge;
  final String? advertisementType;
  final VerifyLocationEntity? location;
  final String? propertyFace;
  final String? planNumber;
  final String? landNumber;
  final String? obligationsOnTheProperty;
  final String? guaranteesAndTheirDuration;
  final bool? complianceWithTheSaudiBuildingCode;
  
  final List<String>? channels;
  final List<dynamic>? propertyUsages;
  final String? mainLandUseTypeName;
  final String? redZoneTypeName;
  final List<String>? propertyUtilities;
  final String? creationDate;
  final String? endDate;
  final String? adLicenseUrl;
  final String? adSource;
  final String? titleDeedTypeName;
  final String? locationDescriptionOnMOJDeed;
  final String? notes;
  final VerifyBordersEntity? borders;
  final List<dynamic>? rerBorders;
  final String? ownershipTransferFeeType;
}
