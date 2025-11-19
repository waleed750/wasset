import 'dart:convert';

import 'package:waseet/features/user/domain/entities/packages_entity.dart';

class PackagesModel {
  PackagesModel({
    this.id,
    this.name,
    this.duration,
    this.features,
    this.price,
  });

  factory PackagesModel.fromMap(Map<String, dynamic> data) => PackagesModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        duration: data['duration'] as String?,
        features: (data['features'] as List?)?.map((e) => e as String).toList(),
        price: data['price'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PackagesModel].
  factory PackagesModel.fromJson(String data) {
    return PackagesModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  int? id;
  String? name;
  String? duration;
  List<String>? features;
  String? price;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'duration': duration,
        'features': features,
        'price': price,
      };

  /// `dart:convert`
  ///
  /// Converts [PackagesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PackagesEntity toEntity() => PackagesEntity(
        id: id,
        name: name,
        duration: duration,
        features: features,
        price: price,
      );
}
