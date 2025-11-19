part of 'advertisements_cubit.dart';

enum AdvertisementsStatus {
  initial,
  loading,
  loaded,
  error,
  addLoading,
  removeLoading,
  addAndRemoveError,
  addAndRemoveSuccess,
  processLoading,
  processSuccess,
  processFailure,
}

class AdvertisementsState extends Equatable {
  const AdvertisementsState({
    this.isSelect,
    this.adType,
    this.propertyType,
    this.neighborhood,
    this.propertyAge,
    this.payMethod,
    this.city,
    this.customProperty = '',
    this.ads = const [],
    this.favds = const [],
    this.status = AdvertisementsStatus.initial,
    this.categories = const [],
    this.cities = const [],
    this.neighborhoods = const [],
    this.description,
    this.addAndRemoveMessage,
    this.errorMessage = '',
    this.processMessage = '',
    this.name,
  });

  final List<bool>? isSelect;
  final String? adType;
  final int? propertyType;
  final String? neighborhood;
  final int? propertyAge;
  final String? payMethod;
  final int? city;
  final String customProperty;
  final List<AdEntity> ads;
  final AdvertisementsStatus status;
  final List<CategoryEntity?> categories;
  final List<CitiesEntity?> cities;
  final List<NeighborhoodEntity?> neighborhoods;
  final String errorMessage;
  final String? addAndRemoveMessage;
  final String processMessage;
  final String? description;
  final String? name;
  final List<AdEntity> favds;
  @override
  List<Object?> get props => [
        customProperty,
        ads,
        status,
        categories,
        cities,
        neighborhoods,
        adType,
        propertyType,
        neighborhood,
        propertyAge,
        payMethod,
        city,
        isSelect,
        favds,
        errorMessage,
        addAndRemoveMessage,
        processMessage,
        description,
        name,
      ];

  /// Creates a copy of the current AdvertisementsState with property changes
  AdvertisementsState copyWith({
    List<bool>? isSelect,
    String? customProperty,
    List<AdEntity>? ads,
    List<AdEntity>? favds,
    AdvertisementsStatus? status,
    List<CategoryEntity>? categories,
    List<CitiesEntity>? cities,
    List<NeighborhoodEntity>? neighborhoods,
    String? adType,
    int? propertyType,
    String? neighborhood,
    int? propertyAge,
    String? payMethod,
    int? city,
    String? errorMessage,
    String? addAndRemoveMessage,
    String? processMessage,
    String? description,
    String? name,
  }) {
    return AdvertisementsState(
      customProperty: customProperty ?? this.customProperty,
      ads: ads ?? this.ads,
      name: name ?? this.name,
      status: status ?? this.status,
      categories: categories ?? this.categories,
      cities: cities ?? this.cities,
      neighborhoods: neighborhoods ?? this.neighborhoods,
      adType: adType ?? this.adType,
      propertyType: propertyType ?? this.propertyType,
      neighborhood: neighborhood ?? this.neighborhood,
      propertyAge: propertyAge ?? this.propertyAge,
      payMethod: payMethod ?? this.payMethod,
      city: city ?? this.city,
      isSelect: isSelect ?? this.isSelect,
      favds: favds ?? this.favds,
      errorMessage: errorMessage ?? this.errorMessage,
      addAndRemoveMessage: addAndRemoveMessage ?? this.addAndRemoveMessage,
      processMessage: processMessage ?? this.processMessage,
      description: description ?? this.description,
    );
  }
}
