class DeveloperUnitInquiryRequest {
  const DeveloperUnitInquiryRequest({
    required this.projectId,
    required this.unitId,
    required this.customerName,
    required this.customerPhone,
    required this.brokerId,
    required this.brokerName,
  });

  final int projectId;
  final int unitId;
  final String customerName;
  final String customerPhone;
  final int brokerId;
  final String brokerName;

  Map<String, dynamic> toJson() => {
        'project_id': projectId,
        'unit_id': unitId,
        'customer_name': customerName,
        'customer_phone': customerPhone,
        'broker_id': brokerId,
        'broker_name': brokerName,
      };
}
