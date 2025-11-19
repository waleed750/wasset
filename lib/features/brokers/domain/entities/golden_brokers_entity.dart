import 'package:equatable/equatable.dart';

class GoldenBrokersEntity extends Equatable {
  const GoldenBrokersEntity({
    required this.customerId,
    required this.articleId,
    required this.article,
    required this.photo,
    required this.name,
  });
  factory GoldenBrokersEntity.fromModel(GoldenBrokersEntity entity) {
    return GoldenBrokersEntity(
      customerId: entity.customerId,
      articleId: entity.articleId,
      article: entity.article,
      photo: entity.photo,
      name: entity.name,
    );
  }

  final String customerId;
  final String articleId;
  final String article;
  final String photo;
  final String name;

  @override
  // TODO: implement props
  List<Object?> get props => [
        customerId,
        articleId,
        article,
        photo,
        name,
      ];
}
