part of 'developer_projects_cubit.dart';

enum DeveloperProjectsStatus {
  initial,
  loading,
  loaded,
  error,
  loadingMore,
}

class DeveloperProjectsState extends Equatable {
  const DeveloperProjectsState({
    this.status = DeveloperProjectsStatus.initial,
    this.projects = const [],
    this.categories = const [],
    this.cities = const [],
    this.selectedCategory,
    this.selectedCityId,
    this.errorMessage = '',
    this.currentPage = 1,
    this.lastPage = 1,
    this.hasMore = false,
  });

  final DeveloperProjectsStatus status;
  final List<DeveloperProjectEntity> projects;
  final List<DeveloperCategoryEntity> categories;
  final List<DeveloperCityEntity> cities;
  final String? selectedCategory;
  final int? selectedCityId;
  final String errorMessage;
  final int currentPage;
  final int lastPage;
  final bool hasMore;

  @override
  List<Object?> get props => [
        status,
        projects,
        categories,
        cities,
        selectedCategory,
        selectedCityId,
        errorMessage,
        currentPage,
        lastPage,
        hasMore,
      ];

  DeveloperProjectsState copyWith({
    DeveloperProjectsStatus? status,
    List<DeveloperProjectEntity>? projects,
    List<DeveloperCategoryEntity>? categories,
    List<DeveloperCityEntity>? cities,
    String? selectedCategory,
    int? selectedCityId,
    String? errorMessage,
    int? currentPage,
    int? lastPage,
    bool? hasMore,
  }) {
    return DeveloperProjectsState(
      status: status ?? this.status,
      projects: projects ?? this.projects,
      categories: categories ?? this.categories,
      cities: cities ?? this.cities,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedCityId: selectedCityId ?? this.selectedCityId,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}
