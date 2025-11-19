// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class ConnectionRequest extends Equatable {
  final String? purpose;
  final String? description;
  final int? city;
  final int? category;
  final String? communicationMethod;

  const ConnectionRequest({
    required this.purpose,
    required this.description,
    required this.city,
    required this.category,
    required this.communicationMethod,
  });

  @override
  List<Object?> get props {
    return [
      purpose,
      description,
      city,
      category,
      communicationMethod,
    ];
  }

  Map<String, dynamic> toJson() => {
        'purpose': purpose,
        'description': description,
        'city_id': city,
        'category_id': category,
        'sub_category_id': category,
        'communication_method': communicationMethod,
      };
}
