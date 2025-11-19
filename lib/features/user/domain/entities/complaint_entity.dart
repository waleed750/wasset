import 'package:equatable/equatable.dart';
import 'package:waseet/features/user/data/models/complaint.model.dart';

class ComplaintEntity extends Equatable {
  const ComplaintEntity({
    this.id,
    this.description,
    this.userId,
    this.type,
    this.allianceId,
    this.advertisingLicenseNumber,
    this.status,
  });

  factory ComplaintEntity.fromModel(Complaint entity) => ComplaintEntity(
      id: entity.id,
      description: entity.description,
      userId: entity.userId,
      type: entity.type,
      allianceId: entity.allianceId,
      advertisingLicenseNumber: entity.advertisingLicenseNumber,
      status: entity.status);
  final int? id;
  final String? description;
  final int? userId;
  final String? type;
  final String? status;
  final int? allianceId;
  final int? advertisingLicenseNumber;

  @override
  List<Object?> get props {
    return [
      id,
      description,
      userId,
      type,
      allianceId,
      advertisingLicenseNumber,
      status,
    ];
  }
}
