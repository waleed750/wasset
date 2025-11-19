import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  const CategoryEntity({this.id, this.name, this.subCategory,  this.mainCategory});
  final int? id;
  final String? name;
  final List<CategoryEntity>? subCategory;
  final int? mainCategory;

  @override
  List<Object?> get props => [id, name, subCategory];

  @override
  String toString() {
    return name ?? '';
  }
}
