import 'dart:convert';

import 'package:waseet/features/user/data/models/sub_category.dart';
import 'package:waseet/features/user/domain/entities/category/category_entity.dart';

class CategoryModel {
  CategoryModel({this.id, this.name, this.subCategory, this.mainCategory});

  factory CategoryModel.fromMap(Map<String, dynamic> data) => CategoryModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        subCategory: (data['sub_category'] as List<dynamic>?)
            ?.map((e) => SubCategory.fromMap(e as Map<String, dynamic>))
            .toList(),
        mainCategory: data['category_id'] as int?,
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CategoryModel]
  factory CategoryModel.fromJson(String data) {
    return CategoryModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }
  int? id;
  String? name;
  List<SubCategory>? subCategory;
  int? mainCategory;

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'sub_category': subCategory?.map((e) => e.toMap()).toList(),
        'category_id': mainCategory,
      };

  /// `dart:convert`
  ///
  /// Converts [CategoryModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CategoryEntity toEntity() {
    return CategoryEntity(
      id: id,
      name: name,
      subCategory: subCategory?.map((e) => e.toEntity()).toList(),
      mainCategory: mainCategory,
    );
  }
}
