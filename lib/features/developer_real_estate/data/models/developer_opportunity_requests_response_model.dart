import 'package:waseet/features/developer_real_estate/data/models/developer_opportunity_request_model.dart';

String? _safeParseString(dynamic value) {
  if (value == null) return null;
  return value.toString();
}

int? _safeParseInt(dynamic value) {
  if (value == null) return null;
  if (value is int) return value;
  if (value is double) return value.toInt();
  if (value is String) return int.tryParse(value);
  return null;
}

class DeveloperOpportunityFilterModel {

  DeveloperOpportunityFilterModel({
    required this.id,
    required this.name,
  });

  factory DeveloperOpportunityFilterModel.fromJson(Map<String, dynamic> json) {
    return DeveloperOpportunityFilterModel(
      id: _safeParseInt(json['id']) ?? 0,
      name: _safeParseString(json['name']) ?? '',
    );
  }
  final int id;
  final String name;
}

class DeveloperOpportunityRequestsResponseModel {

  DeveloperOpportunityRequestsResponseModel({
    required this.data,
    this.currentPage,
    this.lastPage,
    this.total,
    this.perPage,
  });

  factory DeveloperOpportunityRequestsResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final dataList = <DeveloperOpportunityRequestModel>[];
    
    if (json['data'] is List) {
      for (final item in json['data'] as List) {
        if (item is Map<String, dynamic>) {
          dataList.add(DeveloperOpportunityRequestModel.fromJson(item));
        }
      }
    }

    final meta = json['meta'] as Map<String, dynamic>? ?? {};

    return DeveloperOpportunityRequestsResponseModel(
      data: dataList,
      currentPage: _safeParseInt(meta['current_page']),
      lastPage: _safeParseInt(meta['last_page']),
      total: _safeParseInt(meta['total']),
      perPage: _safeParseInt(meta['per_page']),
    );
  }
  final List<DeveloperOpportunityRequestModel> data;
  final int? currentPage;
  final int? lastPage;
  final int? total;
  final int? perPage;
}

class DeveloperOpportunityDetailResponseModel {

  DeveloperOpportunityDetailResponseModel({this.data});

  factory DeveloperOpportunityDetailResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final dataJson = json['data'] as Map<String, dynamic>?;
    return DeveloperOpportunityDetailResponseModel(
      data: dataJson != null
          ? DeveloperOpportunityRequestModel.fromJson(dataJson)
          : null,
    );
  }
  final DeveloperOpportunityRequestModel? data;
}

class DeveloperOpportunityFiltersResponseModel {

  DeveloperOpportunityFiltersResponseModel({
    required this.opportunityTypes,
    required this.communicationRequestTypes,
    required this.developers,
  });

  factory DeveloperOpportunityFiltersResponseModel.fromOppTypes(
    Map<String, dynamic> json,
  ) {
    final dataList = <DeveloperOpportunityFilterModel>[];
    if (json['data'] is List) {
      for (final item in json['data'] as List) {
        if (item is Map<String, dynamic>) {
          dataList.add(DeveloperOpportunityFilterModel.fromJson(item));
        }
      }
    }
    return DeveloperOpportunityFiltersResponseModel(
      opportunityTypes: dataList,
      communicationRequestTypes: [],
      developers: [],
    );
  }

  factory DeveloperOpportunityFiltersResponseModel.fromCommTypes(
    Map<String, dynamic> json,
  ) {
    final dataList = <DeveloperOpportunityFilterModel>[];
    if (json['data'] is List) {
      for (final item in json['data'] as List) {
        if (item is Map<String, dynamic>) {
          dataList.add(DeveloperOpportunityFilterModel.fromJson(item));
        }
      }
    }
    return DeveloperOpportunityFiltersResponseModel(
      opportunityTypes: [],
      communicationRequestTypes: dataList,
      developers: [],
    );
  }

  factory DeveloperOpportunityFiltersResponseModel.fromDevelopers(
    Map<String, dynamic> json,
  ) {
    final dataList = <DeveloperOpportunityFilterModel>[];
    if (json['data'] is List) {
      for (final item in json['data'] as List) {
        if (item is Map<String, dynamic>) {
          dataList.add(DeveloperOpportunityFilterModel.fromJson(item));
        }
      }
    }
    return DeveloperOpportunityFiltersResponseModel(
      opportunityTypes: [],
      communicationRequestTypes: [],
      developers: dataList,
    );
  }
  final List<DeveloperOpportunityFilterModel> opportunityTypes;
  final List<DeveloperOpportunityFilterModel> communicationRequestTypes;
  final List<DeveloperOpportunityFilterModel> developers;

  DeveloperOpportunityFiltersResponseModel merge(
    DeveloperOpportunityFiltersResponseModel other,
  ) {
    return DeveloperOpportunityFiltersResponseModel(
      opportunityTypes: [
        ...opportunityTypes,
        ...other.opportunityTypes,
      ],
      communicationRequestTypes: [
        ...communicationRequestTypes,
        ...other.communicationRequestTypes,
      ],
      developers: [
        ...developers,
        ...other.developers,
      ],
    );
  }
}
