// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tahalfat_cubit.dart';

enum TahalfatStatus {
  initial,
  loading,
  loaded,
  error,
  attachLoading,
  processLoading,
  processSuccess,
  processFailure,
}

class TahalfatState extends Equatable {
  const TahalfatState({
    this.selectedBrokerType,
    this.selectedTahalfType,
    this.selectedCity,
    this.selectedCategory,
    this.passWord,
    this.categories = const [],
    this.cities = const [],
    this.errorMessage = '',
    this.processMessage = '',
    this.tahalfList = const [],
    this.joinedTahalfList = const [],
    this.myTahalfList = const [],
    this.status = TahalfatStatus.initial,
    this.description,
    this.name,
  });

  final String errorMessage;
  final String processMessage;
  final List<TahalfEntity> tahalfList;
  final List<TahalfEntity> myTahalfList;
  final List<TahalfEntity> joinedTahalfList;
  final TahalfatStatus status;
  final List<CitiesEntity> cities;
  final List<CategoryEntity> categories;
  final CategoryEntity? selectedCategory;
  final CitiesEntity? selectedCity;
  final String? selectedBrokerType;
  final String? selectedTahalfType;
  final String? description;
  final String? name;
  final String? passWord;

  @override
  List<Object?> get props => [
        errorMessage,
        tahalfList,
        myTahalfList,
        joinedTahalfList,
        status,
        cities,
        selectedBrokerType,
        selectedCity,
        selectedTahalfType,
        processMessage,
        description,
        categories,
        selectedCategory,
        name,
        passWord,
      ];

  TahalfatState copyWith({
    String? errorMessage,
    String? description,
    String? passWord,
    String? name,
    String? processMessage,
    List<CitiesEntity>? cities,
    CitiesEntity? selectedCity,
    String? selectedBrokerType,
    String? selectedTahalfType,
    List<TahalfEntity>? tahalfList,
    List<TahalfEntity>? myTahalfList,
    List<TahalfEntity>? joinedTahalfList,
    TahalfatStatus? status,
    List<CategoryEntity>? categories,
    CategoryEntity? selectedCategory,
  }) {
    return TahalfatState(
      errorMessage: errorMessage ?? this.errorMessage,
      processMessage: processMessage ?? this.processMessage,
      tahalfList: tahalfList ?? this.tahalfList,
      myTahalfList: myTahalfList ?? this.myTahalfList,
      joinedTahalfList: joinedTahalfList ?? this.joinedTahalfList,
      status: status ?? this.status,
      cities: cities ?? this.cities,
      passWord: passWord ?? this.passWord,
      selectedCity: selectedCity ?? this.selectedCity,
      selectedBrokerType: selectedBrokerType ?? this.selectedBrokerType,
      selectedTahalfType: selectedTahalfType ?? this.selectedTahalfType,
      description: description ?? this.description,
      name: name ?? this.name,
      categories: categories ?? this.categories,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}

class MyTahalfatInitial extends TahalfatState {
  const MyTahalfatInitial() : super();
}
