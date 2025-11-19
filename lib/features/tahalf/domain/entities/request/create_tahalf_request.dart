// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class CreateTahalfRequest extends Equatable {
  final String? name;
  final int? city;
  final List<int>? catigories;
  final List<String>? wassetType;
  final String? tahalfPurpose;
  final String? tahalfType;
  final String? passWord;

  const CreateTahalfRequest({
    this.tahalfType,
    this.wassetType,
    this.catigories,
    this.tahalfPurpose,
    this.name,
    this.city,
    this.passWord,
  });

  @override
  List<Object?> get props {
    return [
      name,
      tahalfPurpose,
      wassetType,
      catigories,
      city,
      tahalfType,
      passWord,
    ];
  }

  Map<String, dynamic> toMapPrivate() {
    return {
      'name': name,
      'purpose': tahalfPurpose,
      'alliance_type': tahalfType,
      'wasset_type': wassetType,
      'city_id': city,
      'categories': catigories,
      'password': passWord,
    };
  }

  Map<String, dynamic> toMapPublic() {
    return {
      'name': name,
      'purpose': tahalfPurpose,
      'alliance_type': tahalfType,
      'wasset_type': wassetType,
      'city_id': city,
      'categories': catigories,
    };
  }
}
