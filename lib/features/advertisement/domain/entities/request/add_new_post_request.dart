class AddNewPostRequest {
  AddNewPostRequest({
    this.id,
    required this.title,
    required this.content,
  });
  final int? id;
  final String title;
  final String content;

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
    };
  }
}
