mixin BasePaginationResponse<T> {
  int? status;
  String? message;
  Map<String, dynamic>? errors;
  List<T>? data;
  int? currentPage;
  int? lastPage;
  int? total;
  String? nextPageUrl;

  fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic> item)? builder,
  }) {
    status = json['status'] as int?;
    message = json['message'] as String?;
    errors = json['errors'] as Map<String, dynamic>?;
    final meta = json['meta'] as Map<String, dynamic>? ?? {};
    final links = json['links'] as Map<String, dynamic>? ?? {};
    currentPage = meta['current_page'] as int?;
    lastPage = meta['last_page'] as int?;
    total = meta['total'] as int?;
    nextPageUrl = links['next'] as String?;
    if (json['data'] != null) {
      data = [];
      if (json['data'] is List) {
        for (final item in json['data'] as List) {
          data?.add(builder!(item as Map<String, dynamic>));
        }
      } else {
        final mapToList = [json['data']];
        for (final item in mapToList) {
          data?.add(builder!(item as Map<String, dynamic>));
        }
      }
    }
  }
}
