import 'dart:convert';

import 'package:waseet/features/user/domain/entities/category/category_entity.dart';

class SubCategory {
  SubCategory({this.id, this.name});

  factory SubCategory.fromMap(Map<String, dynamic> data) => SubCategory(
        id: data['id'] as int?,
        name: data['name'] as String?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SubCategory].
  factory SubCategory.fromJson(String data) {
    return SubCategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  int? id;
  String? name;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Converts [SubCategory] to a JSON string.
  String toJson() => json.encode(toMap());

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
    );
  }
}
