class DeveloperUnitInquiryRequest {
  const DeveloperUnitInquiryRequest({
    required this.customerName,
    required this.customerPhone,
    required this.notes,
    required this.effortLevel,
  });

  final String customerName;
  final String customerPhone;
  final String notes;
  final String effortLevel;

  Map<String, dynamic> toJson() => {
        'customer_name': customerName,
        'customer_phone': customerPhone,
        'notes': notes,
        'effort_level': effortLevel,
      };
}
