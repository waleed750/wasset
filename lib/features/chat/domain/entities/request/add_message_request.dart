// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddMessageRequest {
  String? filePath;
  String? fileName;
  String? message;
  String? userId;
  DateTime? createdAt;
  String? type;
  String? receiverToken;
  String? name;
  String? imageUrl;
  String? chatId;

  AddMessageRequest({
    this.message,
    this.filePath,
    this.fileName,
    this.userId,
    this.createdAt,
    this.type,
    this.receiverToken,
    this.name,
    this.imageUrl,
    this.chatId,
  });

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (message != null) {
      json['content'] = message;
    }
    if (filePath != null) {
      json['file_path'] = filePath;
    }
    if (fileName != null) {
      json['file_name'] = fileName;
    }
    if (userId != null) {
      json['user_id'] = userId;
    }
    if (createdAt != null) {
      json['created_at'] = createdAt!.millisecondsSinceEpoch;
    }
    if (type != null) {
      json['type'] = type;
    }
    json['seen_at'] = null;
    json['name'] = name;
    json['image_url'] = imageUrl;

    return json;
  }

  AddMessageRequest copyWith({
    String? filePath,
    String? fileName,
    String? message,
    String? userId,
    DateTime? createdAt,
    String? type,
    String? receiverToken,
    String? name,
    String? imageUrl,
    String? chatId,
  }) {
    return AddMessageRequest(
      filePath: filePath ?? this.filePath,
      fileName: fileName ?? this.fileName,
      message: message ?? this.message,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      receiverToken: receiverToken ?? this.receiverToken,
      name: name ?? this.name,
      imageUrl: imageUrl ?? this.imageUrl,
      chatId: chatId ?? this.chatId,
    );
  }
}
