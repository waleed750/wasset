// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:waseet/features/user/data/models/wasset_user_model.dart';

class MessageEntity {
  static const sentState = 1;
  static const pendingState = 0;

  String? id;
  String? userId;
  String? message;
  String? fileName;
  String? fileExtension;
  String? filePath;
  File? fileInternal;
  int? status;
  DateTime? createdAt;
  DateTime? seenAt;
  String? type;
  String? name;
  String? imageUrl;
  WassetUserModel? sender;

  MessageEntity({
    this.id,
    this.userId,
    this.message,
    this.status,
    this.fileInternal,
    this.fileName,
    this.fileExtension,
    this.filePath,
    this.createdAt,
    this.seenAt,
    this.type,
    this.name,
    this.imageUrl,
    this.sender,
  });
}
