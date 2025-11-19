class ComplaintRequest {
  ComplaintRequest({
    required this.description,
    this.userId,
    required this.type,
    this.allianceId,
    this.advertisementId,
    this.communicationRequestId,
  });

  final String description;
  final int? userId;
  final String type;
  final int? allianceId;
  final int? advertisementId;
  final int? communicationRequestId;
  Map<String, dynamic> toJson() => {
        'description': description,
        'type': type,
        'user_id': userId,
        'alliance_id': allianceId,
        'advertisement_id': advertisementId,
        'communication_request_id': communicationRequestId,
      };
}
