// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'update_connection_request_cubit.dart';

enum UpdateConnectionRequestStatus { initial, loading, loaded, error, success }

class UpdateConnectionRequestState extends Equatable {
  const UpdateConnectionRequestState({
    this.cities = const [],
    this.request,
    this.selectedCity,
    this.categories = const [],
    this.selectedCategory,
    this.createMessage = '',
    this.description,
    this.communicationMethod = CommunicationMethod.message,
    this.status = UpdateConnectionRequestStatus.initial,
    this.errorMessage = '',
    this.isForBuy = true,
  });
  final ConnectionRequestEntity? request;
  final List<CitiesEntity> cities;
  final int? selectedCity;
  final List<CategoryEntity> categories;
  final int? selectedCategory;
  final String createMessage;
  final UpdateConnectionRequestStatus status;
  final String? description;
  final String errorMessage;
  final bool isForBuy;
  final CommunicationMethod communicationMethod;
  @override
  List<Object?> get props {
    return [
      status,
      cities,
      selectedCity,
      categories,
      selectedCategory,
      createMessage,
      description,
      errorMessage,
      communicationMethod,
      isForBuy,
      request,
    ];
  }

  UpdateConnectionRequestState copyWith({
    List<CitiesEntity>? cities,
    int? selectedCity,
    List<CategoryEntity>? categories,
    int? selectedCategory,
    String? createMessage,
    UpdateConnectionRequestStatus? status,
    String? description,
    String? errorMessage,
    CommunicationMethod? communicationMethod,
    bool? isForBuy,
    ConnectionRequestEntity? request,
  }) {
    return UpdateConnectionRequestState(
      cities: cities ?? this.cities,
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      description: description ?? this.description,
      isForBuy: isForBuy ?? this.isForBuy,
      communicationMethod: communicationMethod ?? this.communicationMethod,
      request: request ?? this.request,
    );
  }
}

class UpdateConnectionRequestInitial extends UpdateConnectionRequestState {
  const UpdateConnectionRequestInitial() : super();
}
