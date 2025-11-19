import 'package:equatable/equatable.dart';

class GoldenBrokers extends Equatable {
  final String customerId;
  final String articleId;
  final String article;
  final String photo;
  final String name;

  GoldenBrokers(
      {required this.customerId,
      required this.articleId,
      required this.article,
      required this.photo,
      required this.name});

  @override
  // TODO: implement props
  List<Object?> get props {
    return [customerId, articleId, article, photo, name];
  }
}
