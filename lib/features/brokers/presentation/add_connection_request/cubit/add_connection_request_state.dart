// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'add_connection_request_cubit.dart';

enum AddConnectionRequestStatus { initial, loading, loaded, error, success }

class AddConnectionRequestState extends Equatable {
  const AddConnectionRequestState({
    this.cities = const [],
    this.selectedCity,
    this.categories = const [],
    this.selectedCategory,
    this.createMessage = '',
    this.description,
    this.communicationMethod = CommunicationMethod.message,
    this.status = AddConnectionRequestStatus.initial,
    this.errorMessage = '',
    this.isForBuy = true,
  });
  final List<CitiesEntity> cities;
  final int? selectedCity;
  final List<CategoryEntity> categories;
  final int? selectedCategory;
  final String createMessage;
  final AddConnectionRequestStatus status;
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
      isForBuy
    ];
  }

  AddConnectionRequestState copyWith({
    List<CitiesEntity>? cities,
    int? selectedCity,
    List<CategoryEntity>? categories,
    int? selectedCategory,
    String? createMessage,
    AddConnectionRequestStatus? status,
    String? description,
    String? errorMessage,
    CommunicationMethod? communicationMethod,
    bool? isForBuy,
  }) {
    return AddConnectionRequestState(
      cities: cities ?? this.cities,
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      description: description ?? this.description,
      isForBuy: isForBuy ?? this.isForBuy,
      communicationMethod: communicationMethod ?? this.communicationMethod,
    );
  }
}

class AddConnectionRequestInitial extends AddConnectionRequestState {
  const AddConnectionRequestInitial() : super();
}
