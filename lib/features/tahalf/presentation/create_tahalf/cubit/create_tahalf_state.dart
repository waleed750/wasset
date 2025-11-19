// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'create_tahalf_cubit.dart';

enum CreateTahalfStatus { initial, loading, loaded, error, success }

class CreateTahalfState extends Equatable {
  const CreateTahalfState({
    this.errorMessage = '',
    this.status = CreateTahalfStatus.initial,
    this.name,
    this.pw,
    this.tahalfType = 'public',
    this.createMessage = '',
    this.cities = const [],
    this.selectedCity,
    this.categories = const [],
    this.subCategories,
    this.selectedCategories,
    this.brokerTypes,
    this.selectedBrokerType,
    this.tahalfPurpose,
    this.approval = false,
  });
  final String errorMessage;

  final CreateTahalfStatus status;
  final String? name;
  final String? pw;
  final String tahalfType;
  final String createMessage;
  final List<CitiesEntity> cities;
  final int? selectedCity;
  final List<CategoryEntity> categories;
  final List<CategoryEntity>? subCategories;
  final List<CategoryEntity>? selectedCategories;
  final List<BrokerType>? brokerTypes;
  final List<BrokerType>? selectedBrokerType;
  final TahalfPurposeType? tahalfPurpose;
  final bool approval;

  @override
  List<Object?> get props {
    return [
      errorMessage,
      status,
      tahalfType,
      cities,
      selectedCity,
      categories,
      selectedCategories,
      subCategories,
      name,
      brokerTypes,
      selectedBrokerType,
      tahalfPurpose,
      approval,
      createMessage,
      pw
    ];
  }

  /// Creates a copy of the current CreateTahalfState with property changes
  CreateTahalfState copyWith({
    String? errorMessage,
    CreateTahalfStatus? status,
    String? name,
    String? pw,
    String? tahalfType,
    String? createMessage,
    List<CitiesEntity>? cities,
    int? selectedCity,
    List<CategoryEntity>? categories,
    List<CategoryEntity>? subCategories,
    List<CategoryEntity>? selectedCategories,
    List<BrokerType>? brokerTypes,
    List<BrokerType>? selectedBrokerType,
    TahalfPurposeType? tahalfPurpose,
    bool? approval,
  }) {
    return CreateTahalfState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      name: name ?? this.name,
      pw: pw ?? this.pw,
      tahalfType: tahalfType ?? this.tahalfType,
      createMessage: createMessage ?? this.createMessage,
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      categories: categories ?? this.categories,
      subCategories: subCategories ?? this.subCategories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      brokerTypes: brokerTypes ?? this.brokerTypes,
      selectedBrokerType: selectedBrokerType ?? this.selectedBrokerType,
      tahalfPurpose: tahalfPurpose ?? this.tahalfPurpose,
      approval: approval ?? this.approval,
    );
  }
}

class CreateTahalfInitial extends CreateTahalfState {
  const CreateTahalfInitial() : super();
}
