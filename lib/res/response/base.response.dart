mixin BaseResponse<T> {
  int? status;
  String? message;
  Map<String, dynamic>? errors;
  List<T>? data;

  fromJson(
    Map<String, dynamic> json, {
    T Function(Map<String, dynamic> item)? builder,
  }) {
    status = json['status'] as int?;
    message = json['message'] as String?;
    errors = json['errors'] as Map<String, dynamic>?;
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
