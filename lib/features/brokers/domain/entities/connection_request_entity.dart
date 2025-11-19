import 'package:waseet/features/user/domain/entities/category/category_entity.dart';
import 'package:waseet/features/user/domain/entities/cities_entity.dart';
import 'package:waseet/features/user/domain/entities/wasset_profile_entity.dart';

class ConnectionRequestEntity {
  ConnectionRequestEntity({
    required this.id,
    required this.purpose,
    required this.type,
    required this.description,
    required this.city,
    required this.category,
    required this.createdBy,
    required this.communicationMethod,
    this.isFav = false,
  });
  factory ConnectionRequestEntity.fromModel(ConnectionRequestEntity entity) {
    return ConnectionRequestEntity(
      id: entity.id,
      type: entity.type,
      purpose: entity.purpose,
      description: entity.description,
      city: entity.city,
      category: entity.category,
      createdBy: entity.createdBy,
      communicationMethod: entity.communicationMethod,
    );
  }
  final int id;
  final String purpose;
  final String type;
  final String description;
  final CitiesEntity city;
  final CategoryEntity category;
  final WassetProfileEntity createdBy;
  final String communicationMethod;
  bool isFav;

  bool get showChatOption => communicationMethod == 'chat';
  bool get showCallOption => communicationMethod == 'call';
  bool get showWhatsappOption => communicationMethod == 'whatsapp';
}
