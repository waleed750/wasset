class GetPostsRequest {
  GetPostsRequest({
    this.page = 1,
    this.limit = 20,
    this.id = 0,
  });
  final int page;
  final int limit;
  final int id;

  Map<String, dynamic> toMap() {
    return {
      // 'page': page,
      // 'limit': limit,
      // 'user_id': id,
    };
  }
}
