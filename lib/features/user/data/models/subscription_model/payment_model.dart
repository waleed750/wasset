import 'package:waseet/features/user/domain/entities/subscription/payment_entity.dart';

class PaymentModel {
  PaymentModel({
    this.id,
    this.transactionsId,
    this.amount,
    this.fee,
    this.callbackUrl,
    this.status,
    this.sourceType,
    this.sourceCompany,
    this.sourceName,
    this.sourceTransactionUrl,
    this.referenceNumber,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
        id: json['id'] as int?,
        transactionsId: json['transactions_id'] as String?,
        amount: json['amount'] as String?,
        fee: json['fee'] as String?,
        callbackUrl: json['callback_url'] as String?,
        status: json['status'] as String?,
        sourceType: json['source_type'] as String?,
        sourceCompany: json['source_company'] as String?,
        sourceName: json['source_name'] as String?,
        sourceTransactionUrl: json['source_transaction_url'] as String?,
        referenceNumber: json['reference_number'] as dynamic,
      );
  int? id;
  String? transactionsId;
  String? amount;
  String? fee;
  String? callbackUrl;
  String? status;
  String? sourceType;
  String? sourceCompany;
  String? sourceName;
  String? sourceTransactionUrl;
  dynamic referenceNumber;

  Map<String, dynamic> toJson() => {
        'id': id,
        'transactions_id': transactionsId,
        'amount': amount,
        'fee': fee,
        'callback_url': callbackUrl,
        'status': status,
        'source_type': sourceType,
        'source_company': sourceCompany,
        'source_name': sourceName,
        'source_transaction_url': sourceTransactionUrl,
        'reference_number': referenceNumber,
      };

  PaymentEntity toEntity() {
    return PaymentEntity(
      id: id,
      transactionsId: transactionsId,
      amount: amount,
      fee: fee,
      callbackUrl: callbackUrl,
      status: status,
      sourceType: sourceType,
      sourceCompany: sourceCompany,
      sourceName: sourceName,
      sourceTransactionUrl: sourceTransactionUrl,
      referenceNumber: referenceNumber,
    );
  }
}
