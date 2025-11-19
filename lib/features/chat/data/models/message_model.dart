// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:waseet/features/chat/domain/entities/message_model.dart';
import 'package:waseet/features/user/data/models/wasset_user_model.dart';

class MessageModel {
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

  MessageModel({
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

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String?;
    userId = json['user_id'] as String?;
    status = json['status'] as int? ?? 1;
    message = json['content'] as String? ?? '';
    fileName = json['file_name'] as String? ?? '';
    fileExtension = json['file_extension'] as String? ?? '';
    filePath = json['file_path'] as String?;
    name = json['name'] as String?;
    imageUrl = json['image_url'] as String?;
    sender = json['sender'] != null
        ? WassetUserModel.fromMap(json['sender'] as Map<String, dynamic>)
        : null;
    try {
      if (json['sended_at'] is String) {
        createdAt =
            DateTime.tryParse(json['sended_at'].toString())?.toLocal() ??
                DateTime.now();
      } else {
        createdAt =
            DateTime.fromMillisecondsSinceEpoch(json['sended_at'] as int)
                .toLocal();
      }
    } catch (e) {
      createdAt = DateTime.now();
    }
    type = json['type'] as String? ?? 'content';
    seenAt = (json['seen_at'] != null && json['seen_at'] != '')
        ? (DateTime.tryParse(json['seen_at'].toString()) ??
            DateTime.fromMillisecondsSinceEpoch(json['seen_at'] as int))
        : null;
    if (message!.isEmpty) {
      message = null;
    }
    if (fileName!.isEmpty) {
      fileName = null;
    }
    if (filePath?.isEmpty ?? true) {
      filePath = null;
    }
    if (fileExtension!.isEmpty) {
      fileExtension = null;
    }
    if (type!.isEmpty) {
      type = null;
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['sended_at'] = DateTime.now().millisecondsSinceEpoch;
    data['status'] = status;
    data['seen_at'] = seenAt;
    data['id'] = id;
    data['name'] = name;
    data['image_url'] = imageUrl;
    if (message != null) {
      data['content'] = message;
    }
    if (fileName != null) {
      data['file_name'] = fileName;
    }
    if (fileExtension != null) {
      data['file_extension'] = fileExtension;
    }
    if (filePath != null) {
      data['file_path'] = filePath;
    }
    data['type'] = type ?? 'content';
    return data;
  }

  MessageEntity toEntity() {
    return MessageEntity(
      id: id,
      userId: userId,
      message: message,
      status: status,
      fileInternal: fileInternal,
      fileName: fileName,
      fileExtension: fileExtension,
      filePath: filePath,
      createdAt: createdAt,
      seenAt: seenAt,
      type: type,
      name: name,
      imageUrl: imageUrl,
      sender: sender,
    );
  }
}
