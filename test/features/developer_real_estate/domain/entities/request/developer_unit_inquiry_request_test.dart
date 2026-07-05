import 'package:flutter_test/flutter_test.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/request/developer_unit_inquiry_request.dart';

void main() {
  test('serializes potential customer payload', () {
    const request = DeveloperUnitInquiryRequest(
      customerName: 'عميل تجريبي',
      customerPhone: '0500000000',
      notes: 'مهتم بالوحدة',
      effortLevel: 'high',
    );

    expect(request.toJson(), {
      'customer_name': 'عميل تجريبي',
      'customer_phone': '0500000000',
      'notes': 'مهتم بالوحدة',
      'effort_level': 'high',
    });
  });
}
