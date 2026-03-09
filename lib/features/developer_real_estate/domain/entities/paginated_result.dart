/// Wrapper class to preserve pagination metadata from API responses
class PaginatedResult<T> {

  PaginatedResult({
    required this.data,
    required this.currentPage,
    required this.lastPage,
    this.total,
    this.nextPageUrl,
  });
  final List<T> data;
  final int currentPage;
  final int lastPage;
  final int? total;
  final String? nextPageUrl;

  bool get hasMore => currentPage < lastPage || nextPageUrl != null;
}
