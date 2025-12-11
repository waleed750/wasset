// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'kingdom_broker_cubit.dart';

enum BrokerStatus {
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
  loadingMore,
}

class KingdomBrokerState extends Equatable {
  const KingdomBrokerState({
    this.errorMessage = '',
    this.addAndRemoveBrokerMessage,
    this.processMessage,
    this.description,
    this.status = BrokerStatus.initial,
    this.brokers = const [],
    this.favBrokers = const [],
    this.categories = const [],
    this.selectedCategories,
    this.selectedTypes,
    this.name,
    this.gender,
    this.currentPage = 1,
    this.hasMore = true,
  });

  final String errorMessage;
  final String? addAndRemoveBrokerMessage;
  final String? processMessage;
  final String? description;
  final BrokerStatus status;
  final List<WassetProfileEntity?> brokers;
  final List<FavBrokerEntity?> favBrokers;
  final List<CategoryEntity> categories;
  final List<CategoryEntity>? selectedCategories;
  final BrokerType? selectedTypes;
  final String? name;
  final String? gender;
  final int currentPage;
  final bool hasMore;
  @override
  List<Object?> get props {
    return [
      processMessage,
      errorMessage,
      status,
      brokers,
      favBrokers,
      categories,
      selectedCategories,
      selectedTypes,
      addAndRemoveBrokerMessage,
      description,
      name,
      gender,
      currentPage,
      hasMore,
    ];
  }

  KingdomBrokerState copyWith({
    String? errorMessage,
    String? addAndRemoveBrokerMessage,
    String? processMessage,
    String? description,
    BrokerStatus? status,
    List<WassetProfileEntity?>? brokers,
    List<FavBrokerEntity?>? favBrokers,
    List<CategoryEntity>? categories,
    List<CategoryEntity>? selectedCategories,
    BrokerType? selectedTypes,
    String? name,
    String? gender,
    int? currentPage,
    bool? hasMore,
  }) {
    return KingdomBrokerState(
      errorMessage: errorMessage ?? this.errorMessage,
      addAndRemoveBrokerMessage:
          addAndRemoveBrokerMessage ?? this.addAndRemoveBrokerMessage,
      processMessage: processMessage ?? this.processMessage,
      description: description ?? this.description,
      status: status ?? this.status,
      brokers: brokers ?? this.brokers,
      favBrokers: favBrokers ?? this.favBrokers,
      categories: categories ?? this.categories,
      selectedCategories: selectedCategories ?? this.selectedCategories,
      selectedTypes: selectedTypes ?? this.selectedTypes,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      currentPage: currentPage ?? this.currentPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

class KingdomBrokerInitial extends KingdomBrokerState {
  const KingdomBrokerInitial() : super();
}
