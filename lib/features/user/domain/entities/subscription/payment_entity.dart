class PaymentEntity {
  PaymentEntity({
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
}
