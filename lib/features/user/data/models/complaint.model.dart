import 'package:equatable/equatable.dart';
import 'package:waseet/features/user/domain/entities/complaint_entity.dart';

class Complaint extends Equatable {
  const Complaint({
    this.id,
    this.description,
    this.userId,
    this.type,
    this.allianceId,
    this.advertisingLicenseNumber,
    this.status,
  });

  factory Complaint.fromJson(Map<String, dynamic> json) => Complaint(
        id: json['id'] as int?,
        description: json['description'] as String?,
        userId: json['user_id'] as int?,
        type: json['type'] as String?,
        allianceId: json['alliance_id'] as int?,
        advertisingLicenseNumber: json['advertising_license_number'] as int?,
        status: json['status'] as String?,
      );
  final int? id;
  final String? description;
  final int? userId;
  final String? type;
  final int? allianceId;
  final int? advertisingLicenseNumber;
  final String? status;
  Map<String, dynamic> toJson() => {
        'description': description,
        'type': type,
        'user_id': userId,
        'alliance_id': allianceId,
        'advertising_license_number': advertisingLicenseNumber,
      };

  ComplaintEntity toEntity() => ComplaintEntity(
        id: id,
        description: description,
        type: type,
        status: status,
        userId: userId,
        allianceId: allianceId,
        advertisingLicenseNumber: advertisingLicenseNumber,
      );

  @override
  List<Object?> get props {
    return [
      id,
      description,
      userId,
      type,
      allianceId,
      advertisingLicenseNumber,
      status
    ];
  }
}
