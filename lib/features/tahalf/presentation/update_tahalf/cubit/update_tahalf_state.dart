// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_tahalf_cubit.dart';

enum UpdateTahalfStatus { initial, loading, loaded, error, success }

class UpdateTahalfState extends Equatable {
  const UpdateTahalfState({
    this.tahalf,
    this.createMessage = '',
    this.tahalfType = 'public',
    this.status = UpdateTahalfStatus.initial,
    this.errorMessage = '',
    this.name,
    this.pw,
    this.cities = const [],
    this.selectedCity,
    this.selectedCategories,
    this.selectedBrokerType,
    this.categories = const [],
    this.brokerTypes,
    this.tahalfPurpose,
    this.approval = true,
    this.changed = false,
  });
  final String errorMessage;
  final String createMessage;
  final UpdateTahalfStatus status;
  final String? name;
  final String? tahalfType;
  final String? pw;
  final TahalfEntity? tahalf;
  final List<CitiesEntity> cities;
  final int? selectedCity;
  final List<CategoryEntity> categories;
  final List<CategoryEntity>? selectedCategories;
  final List<BrokerType>? brokerTypes;
  final List<String>? selectedBrokerType;
  final String? tahalfPurpose;
  final bool approval;
  final bool changed;

  @override
  List<Object?> get props {
    return [
      errorMessage,
      status,
      tahalf,
      tahalfType,
      cities,
      selectedCity,
      categories,
      selectedCategories,
      name,
      brokerTypes,
      selectedBrokerType,
      tahalfPurpose,
      approval,
      createMessage,
      pw,
      changed,
    ];
  }

  UpdateTahalfState copyWith({
    String? errorMessage,
    String? createMessage,
    UpdateTahalfStatus? status,
    String? name,
    String? tahalfType,
    String? pw,
    TahalfEntity? tahalf,
    List<CitiesEntity>? cities,
    int? selectedCity,
    List<CategoryEntity>? categories,
    List<CategoryEntity>? selectedCategories,
    List<BrokerType>? brokerTypes,
    List<String>? selectedBrokerType,
    String? tahalfPurpose,
    bool? approval,
    bool? changed,
  }) {
    return UpdateTahalfState(
      errorMessage: errorMessage ?? this.errorMessage,
      createMessage: createMessage ?? this.createMessage,
      status: status ?? this.status,
      name: name ?? this.name,
      tahalfType: tahalfType ?? this.tahalfType,
      pw: pw ?? this.pw,
      tahalf: tahalf ?? this.tahalf,
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      brokerTypes: brokerTypes ?? this.brokerTypes,
      selectedBrokerType: selectedBrokerType ?? this.selectedBrokerType,
      tahalfPurpose: tahalfPurpose ?? this.tahalfPurpose,
      approval: approval ?? this.approval,
      changed: changed ?? this.changed,
    );
  }
}

class UpdateTahalfInitial extends UpdateTahalfState {
  const UpdateTahalfInitial() : super();
}
