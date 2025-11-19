import 'package:waseet/features/user/domain/entities/wasset_user.dart';

class PostEntity {
  PostEntity({
    required this.id,
    required this.title,
    required this.content,
    this.user,
  });
  final int id;
  final String title;
  final String content;
  final WassetUser? user;
}
