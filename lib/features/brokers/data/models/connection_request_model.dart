import 'dart:convert';

import 'package:waseet/features/brokers/domain/entities/connection_request_entity.dart';
import 'package:waseet/features/user/data/models/category_model.dart';
import 'package:waseet/features/user/data/models/home/cities_model.dart';
import 'package:waseet/features/user/data/models/wasset_user/wasset_user/wasset_profile_model.dart';

class ConnectionRequestModel {
  ConnectionRequestModel({
    this.id,
    this.purpose,
    this.type,
    this.description,
    this.city,
    this.category,
    this.createdBy,
    this.communicationMethod,
  });

  factory ConnectionRequestModel.fromJson(String data) {
    return ConnectionRequestModel.fromMap(
      json.decode(data) as Map<String, dynamic>,
    );
  }

  factory ConnectionRequestModel.fromMap(Map<String, dynamic> data) =>
      ConnectionRequestModel(
        id: data['id'] as int?,
        purpose: data['purpose'] as String?,
        type: data['type'] as String?,
        description: data['description'] as String?,
        city: data['city'] != null
            ? CitiesModel.fromJson(data['city'] as Map<String, dynamic>)
            : null,
        category: data['category'] != null || data['sub_category'] != null
            ? CategoryModel.fromMap(
                data['category'] != null
                    ? data['category'] as Map<String, dynamic>
                    : data['sub_category'] as Map<String, dynamic>,
              )
            : null,
        createdBy: data['createdBy'] != null
            ? WassetProfileModel.fromJson(
                data['createdBy'] as Map<String, dynamic>,
              )
            : null,
        communicationMethod: data['communication_method'] as String?,
      );

  int? id;
  String? purpose;
  String? type;
  String? description;
  CitiesModel? city;
  CategoryModel? category;
  WassetProfileModel? createdBy;
  String? communicationMethod;

  Map<String, dynamic> toJson() => {
        'id': id,
        'purpose': purpose,
        'type': type,
        'description': description,
        'city': city,
        'category': category,
        'createdBy': createdBy,
        'communicationMethod': communicationMethod,
      };

  ConnectionRequestEntity toEntity() {
    return ConnectionRequestEntity(
      id: id!,
      purpose: purpose!,
      type: type ?? '',
      description: description ?? '',
      city: city!.toEntity(),
      category: category!.toEntity(),
      createdBy: createdBy!.toEntity(),
      communicationMethod: communicationMethod ?? '',
    );
  }
}
