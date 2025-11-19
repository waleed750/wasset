import 'dart:convert';

import 'package:waseet/features/tahalf/domain/entities/tahalf_entity.dart';
import 'package:waseet/features/user/data/models/category_model.dart';
import 'package:waseet/features/user/data/models/home/cities_model.dart';
import 'package:waseet/features/user/data/models/home/neighborhood.model.dart';

class TahalfModel {
  TahalfModel({
    this.wassetType,
    this.name,
    this.purpose,
    this.cities,
    this.neighborhoods,
    this.categories,
    this.tahalfType,
  });

  factory TahalfModel.fromJson(String data) {
    return TahalfModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory TahalfModel.fromMap(Map<String, dynamic> data) => TahalfModel(
        name: data['name'] as String?,
        tahalfType: data['alliance_type'] as String,
        purpose: data['purpose'] as String?,
        cities: data['cities'] != null
            ? (data['cities'] as List<dynamic>)
                .map((e) => CitiesModel.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
        neighborhoods: data['neighborhoods'] != null
            ? (data['neighborhoods'] as List<dynamic>)
                .map(
                  (e) => NeighborhoodModel.fromJson(e as Map<String, dynamic>),
                )
                .toList()
            : null,
        categories: data['categories'] != null
            ? (data['categories'] as List<dynamic>)
                .map((e) => CategoryModel.fromMap(e as Map<String, dynamic>))
                .toList()
            : null,
        wassetType: data['wasset_type'] != null
            ? (data['wasset_type'] as List<dynamic>)
                .map((e) => e as String)
                .toList()
            : null,
      );
  String? name;
  String? tahalfType;
  String? purpose;
  List<CitiesModel>? cities;
  List<NeighborhoodModel>? neighborhoods;
  List<CategoryModel>? categories;
  List<String>? wassetType;

  Map<String, dynamic> toJson() => {
        'name': name,
        'purpose': purpose,
        'cities': cities,
        'neighborhoods': neighborhoods,
        'categories': categories,
        'wasset_type': wassetType,
        'alliance_type': tahalfType,
      };

  TahalfEntity toEntity() {
    return TahalfEntity(
      name: name,
      allianceType: tahalfType,
      purpose: purpose,
      city: cities?.map((e) => e.toEntity()).toList().first,
      categories: categories?.map((e) => e.toEntity()).toList(),
    );
  }
}
