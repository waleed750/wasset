// ignore_for_file: public_member_api_docs, sort_constructors_first
class PackageSubscribeRequest {
  final String packageId;
  final String type;
  final String amount;
  final String name;
  final String number;
  final String cvc;
  final String month;
  final String year;
  final String mobile;

  PackageSubscribeRequest({
    required this.packageId,
    required this.type,
    required this.amount,
    required this.name,
    required this.number,
    required this.cvc,
    required this.month,
    required this.year,
    required this.mobile,
  });

  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'amount': amount,
      'name': name,
      'number': number,
      'cvc': cvc,
      'month': month,
      'year': year,
      'mobile': mobile,
    };
  }
}
