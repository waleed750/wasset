// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

class AddAdRequest extends Equatable {
  const AddAdRequest({
    required this.typeOfAdvertisement,
    required this.typeOfAdvertisementExtra,
    required this.categoryId,
    required this.cityId,
    required this.neighborhoodId,
    required this.latitude,
    required this.longitude,
    required this.landSpace,
    required this.meterPrice,
    required this.propertyDispute,
    required this.propertyAge,
    required this.facade,
    required this.streetsCount,
    required this.warranties,
    required this.saudiCode,
    required this.electricityMeter,
    required this.waterMeter,
    required this.negotiable,
    required this.sewerage,
    required this.price,
    required this.paymentMethod,
    required this.communicationMethod,
    required this.extraInfo,
    required this.contactPhone,
    required this.advertiserName,
    required this.advertisingLicenseNumber,
    required this.images,
  });
  final String typeOfAdvertisement;
  final String typeOfAdvertisementExtra;
  final int categoryId;
  final int cityId;
  final int neighborhoodId;
  final double latitude;
  final double longitude;
  final int landSpace;
  final int meterPrice;
  final int propertyAge;
  final String facade;
  final int streetsCount;
  final bool propertyDispute;
  final bool warranties;
  final bool saudiCode;
  final bool electricityMeter;
  final bool waterMeter;
  final bool negotiable;
  final bool sewerage;
  final int price;
  final String paymentMethod;
  final String communicationMethod;
  final String extraInfo;
  final String contactPhone;
  final String advertiserName;
  final int advertisingLicenseNumber;
  final List<File> images;

  Future<Map<String, dynamic>> toJson() async {
    final map = <String, dynamic>{
      'type_of_advertisement': typeOfAdvertisement,
      if (typeOfAdvertisementExtra.isNotEmpty)
        'type_of_advertisement_extra': typeOfAdvertisementExtra,
      'category_id': categoryId,
      'city_id': cityId,
      'neighborhood_id': neighborhoodId,
      'latitude': latitude,
      'longitude': longitude,
      'land_space': landSpace,
      'meter_price': meterPrice,
      'property_age': propertyAge,
      'facade': facade,
      'streets_count': streetsCount,
      'property_dispute': propertyDispute ? 1 : 0,
      'warranties': warranties ? 1 : 0,
      'saudi_code': saudiCode ? 1 : 0,
      'electricity_meter': electricityMeter ? 1 : 0,
      'water_meter': waterMeter ? 1 : 0,
      'negotiable': negotiable ? 1 : 0,
      'sewerage': sewerage ? 1 : 0,
      'price': price,
      'payment_method': paymentMethod,
      'communication_method': communicationMethod,
      'extra_info': extraInfo.isNotEmpty ? extraInfo : 'لا يوجد',
      'contact_phone': contactPhone,
      'advertiser_name': advertiserName,
      'advertising_license_number': advertisingLicenseNumber,
    };

    final multipart = <MultipartFile>[];
    for (final image in images) {
      multipart.add(
        await MultipartFile.fromFile(
          image.path,
          filename: 's${image.path.split('/').last}',
        ),
      );
    }

    map['attachementFile[]'] = multipart;
    // map['attachement'] = multipart;
    // map['attachements'] = multipart;

    return map;
  }

  static const AddAdRequest empty = AddAdRequest(
    typeOfAdvertisement: 'buy',
    typeOfAdvertisementExtra: '',
    categoryId: 1,
    cityId: 1,
    neighborhoodId: 1,
    latitude: 0,
    longitude: 0,
    landSpace: 0,
    meterPrice: 0,
    propertyDispute: false,
    propertyAge: 1,
    facade: 'north',
    streetsCount: 1,
    warranties: false,
    saudiCode: false,
    electricityMeter: false,
    waterMeter: false,
    negotiable: false,
    sewerage: false,
    price: 0,
    paymentMethod: 'cash',
    communicationMethod: 'chat',
    extraInfo: '',
    contactPhone: '',
    advertiserName: '',
    advertisingLicenseNumber: 0,
    images: [],
  );

  AddAdRequest copyWith({
    String? typeOfAdvertisement,
    String? typeOfAdvertisementExtra,
    int? categoryId,
    int? cityId,
    int? neighborhoodId,
    double? latitude,
    double? longitude,
    int? landSpace,
    int? meterPrice,
    bool? propertyDispute,
    int? propertyAge,
    String? facade,
    int? streetsCount,
    bool? warranties,
    bool? saudiCode,
    bool? electricityMeter,
    bool? waterMeter,
    bool? negotiable,
    bool? sewerage,
    int? price,
    String? paymentMethod,
    String? communicationMethod,
    String? extraInfo,
    String? contactPhone,
    String? advertiserName,
    int? advertisingLicenseNumber,
    List<File>? images,
  }) {
    return AddAdRequest(
      typeOfAdvertisement: typeOfAdvertisement ?? this.typeOfAdvertisement,
      typeOfAdvertisementExtra:
          typeOfAdvertisementExtra ?? this.typeOfAdvertisementExtra,
      categoryId: categoryId ?? this.categoryId,
      cityId: cityId ?? this.cityId,
      neighborhoodId: neighborhoodId ?? this.neighborhoodId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      landSpace: landSpace ?? this.landSpace,
      meterPrice: meterPrice ?? this.meterPrice,
      propertyDispute: propertyDispute ?? this.propertyDispute,
      propertyAge: propertyAge ?? this.propertyAge,
      facade: facade ?? this.facade,
      streetsCount: streetsCount ?? this.streetsCount,
      warranties: warranties ?? this.warranties,
      saudiCode: saudiCode ?? this.saudiCode,
      electricityMeter: electricityMeter ?? this.electricityMeter,
      waterMeter: waterMeter ?? this.waterMeter,
      negotiable: negotiable ?? this.negotiable,
      sewerage: sewerage ?? this.sewerage,
      price: price ?? this.price,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      communicationMethod: communicationMethod ?? this.communicationMethod,
      extraInfo: extraInfo ?? this.extraInfo,
      contactPhone: contactPhone ?? this.contactPhone,
      advertiserName: advertiserName ?? this.advertiserName,
      advertisingLicenseNumber:
          advertisingLicenseNumber ?? this.advertisingLicenseNumber,
      images: images ?? this.images,
    );
  }

  @override
  List<Object> get props {
    return [
      typeOfAdvertisement,
      typeOfAdvertisementExtra,
      categoryId,
      cityId,
      neighborhoodId,
      latitude,
      longitude,
      landSpace,
      meterPrice,
      propertyDispute,
      propertyAge,
      facade,
      streetsCount,
      warranties,
      saudiCode,
      electricityMeter,
      waterMeter,
      negotiable,
      sewerage,
      price,
      paymentMethod,
      communicationMethod,
      extraInfo,
      contactPhone,
      advertiserName,
      advertisingLicenseNumber,
      images,
    ];
  }
}
