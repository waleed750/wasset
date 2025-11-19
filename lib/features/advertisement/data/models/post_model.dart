import 'package:waseet/features/advertisement/domain/entities/post_entity.dart';
import 'package:waseet/features/user/data/models/wasset_user_model.dart';
import 'package:waseet/features/user/domain/entities/wasset_user.dart';

class PostModel {
  PostModel({
    required this.id,
    required this.title,
    required this.content,
    required this.user,
  });

  factory PostModel.fromJson(Map<String, dynamic> data) {
    return PostModel(
      id: data['id'] as int,
      title: data['title'] as String,
      content: data['content'] as String,
      user: WassetUserModel.fromMap(data['author'] as Map<String, dynamic>),
    );
  }
  final int id;
  final String title;
  final String content;
  final WassetUserModel user;

  PostEntity toEntity() {
    return PostEntity(
      id: id,
      title: title,
      content: content,
      user: WassetUser.fromModel(user),
    );
  }
}
