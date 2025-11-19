class GetAdsParam {
  GetAdsParam({
    this.brokerId,
    this.categoryId,
    this.locationId,
    this.keyword,
    this.page,
    this.limit,
  });
  final int? brokerId;
  final String? categoryId;
  final String? locationId;
  final String? keyword;
  final String? page;
  final String? limit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (brokerId != null) {
      map['broker_id'] = brokerId;
    }
    if (categoryId != null) {
      map['category_id'] = categoryId;
    }
    if (locationId != null) {
      map['location_id'] = locationId;
    }
    if (keyword != null) {
      map['keyword'] = keyword;
    }
    if (page != null) {
      map['page'] = page;
    }
    if (limit != null) {
      map['limit'] = limit;
    }

    return map;
  }
}
