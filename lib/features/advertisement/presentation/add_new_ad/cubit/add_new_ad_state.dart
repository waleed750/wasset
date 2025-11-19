// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_new_ad_cubit.dart';

enum AddNewAdStatus { initial, loading, success, error, loaded, submitting }

class AddNewAdState extends Equatable {
  /// {@macro add_new_ad}
  const AddNewAdState({
    this.errorMessage = 'Default Value',
    this.addAdRequest = AddAdRequest.empty,
    this.status = AddNewAdStatus.initial,
    this.cities = const [],
    this.neighborhoods = const [],
    this.categories = const [],
  });

  /// A description for customProperty
  final String errorMessage;
  final AddAdRequest addAdRequest;
  final AddNewAdStatus status;
  final List<CitiesEntity> cities;
  final List<NeighborhoodEntity> neighborhoods;
  final List<CategoryEntity> categories;

  @override
  List<Object> get props =>
      [errorMessage, addAdRequest, status, cities, neighborhoods, categories];

  /// Creates a copy of the current AddNewAdState with property changes
  AddNewAdState copyWith({
    String? errorMessage,
    AddAdRequest? addAdRequest,
    AddNewAdStatus? status,
    List<CitiesEntity>? cities,
    List<NeighborhoodEntity>? neighborhoods,
    List<CategoryEntity>? categories,
  }) {
    return AddNewAdState(
      errorMessage: errorMessage ?? this.errorMessage,
      addAdRequest: addAdRequest ?? this.addAdRequest,
      status: status ?? this.status,
      cities: cities ?? this.cities,
      neighborhoods: neighborhoods ?? this.neighborhoods,
      categories: categories ?? this.categories,
    );
  }
}

/// {@template add_new_ad_initial}
/// The initial state of AddNewAdState
/// {@endtemplate}
class AddNewAdInitial extends AddNewAdState {
  /// {@macro add_new_ad_initial}
  const AddNewAdInitial() : super();
}
