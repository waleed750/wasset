import 'package:flutter_test/flutter_test.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/request/developer_unit_inquiry_request.dart';

void main() {
  test('serializes broker unit inquiry payload', () {
    const request = DeveloperUnitInquiryRequest(
      projectId: 10,
      unitId: 20,
      customerName: 'عميل تجريبي',
      customerPhone: '0500000000',
      brokerId: 30,
      brokerName: 'وسيط تجريبي',
    );

    expect(request.toJson(), {
      'project_id': 10,
      'unit_id': 20,
      'customer_name': 'عميل تجريبي',
      'customer_phone': '0500000000',
      'broker_id': 30,
      'broker_name': 'وسيط تجريبي',
    });
  });
}
