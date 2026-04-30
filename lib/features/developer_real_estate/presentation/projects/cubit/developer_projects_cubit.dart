import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_category_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_city_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_real_estate_repository.dart';
import 'package:waseet/res/resource.dart';

part 'developer_projects_state.dart';

class DeveloperProjectsCubit extends Cubit<DeveloperProjectsState> {
  DeveloperProjectsCubit({
    required DeveloperRealEstateRepository repository,
  })  : _repository = repository,
        super(const DeveloperProjectsState()) {
    init();
  }

  final DeveloperRealEstateRepository _repository;

  Future<void> init() async {
    try {
      emit(state.copyWith(status: DeveloperProjectsStatus.loading));

      // Fetch categories first (required)
      final categoriesResult = await _repository.getCategories();
      
      if (categoriesResult is! ResourceSuccess) {
        emit(
          state.copyWith(
            status: DeveloperProjectsStatus.error,
            errorMessage: categoriesResult.message ?? 'فشل جلب الفئات',
          ),
        );
        return;
      }

      // Fetch cities (optional - won't block if fails)
      final citiesResult = await _repository.getCities();
      final cities = citiesResult is ResourceSuccess 
          ? citiesResult.data ?? <DeveloperCityEntity>[] 
          : <DeveloperCityEntity>[];
      
      // Debug: log cities count
      print('[DEBUG] Cities loaded: ${cities.length} cities');
      for (final city in cities) {
        print('[DEBUG] City: id=${city.id}, name=${city.name}');
      }

      final categories = categoriesResult.data ?? [];
      
      // Add "الكل" option at the beginning for categories
      final allCategories = [
        DeveloperCategoryEntity(
          key: 'all',
          label: 'الكل',
        ),
        ...categories,
      ];

      // Fetch projects (no filter = all projects)
      final projectsResult = await _repository.getProjects();

      if (projectsResult is ResourceSuccess) {
        final paginatedResult = projectsResult.data!;

        emit(
          state.copyWith(
            status: DeveloperProjectsStatus.loaded,
            categories: allCategories,
            cities: cities,
            projects: paginatedResult.data,
            currentPage: paginatedResult.currentPage,
            lastPage: paginatedResult.lastPage,
            hasMore: paginatedResult.hasMore,
            selectedCategory: 'all',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: DeveloperProjectsStatus.error,
            errorMessage: projectsResult.message ?? 'فشل جلب المشاريع',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: DeveloperProjectsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> selectCategory(String categoryKey) async {
    if (state.selectedCategory == categoryKey) return;

    try {
      emit(
        state.copyWith(
          status: DeveloperProjectsStatus.loading,
          selectedCategory: categoryKey,
        ),
      );

      // Fetch projects with category and city filters
      final result = await _repository.getProjects(
        category: categoryKey == 'all' ? null : categoryKey,
        cityId: state.selectedCityId,
      );

      if (result is ResourceSuccess) {
        final paginatedResult = result.data!;
        
        emit(
          state.copyWith(
            status: paginatedResult.data.isEmpty
                ? DeveloperProjectsStatus.loaded
                : DeveloperProjectsStatus.loaded,
            projects: paginatedResult.data,
            currentPage: paginatedResult.currentPage,
            lastPage: paginatedResult.lastPage,
            hasMore: paginatedResult.hasMore,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: DeveloperProjectsStatus.error,
            errorMessage: result.message ?? 'حدث خطأ ما',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: DeveloperProjectsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.status == DeveloperProjectsStatus.loadingMore || !state.hasMore) {
      return;
    }

    try {
      emit(state.copyWith(status: DeveloperProjectsStatus.loadingMore));

      final nextPage = state.currentPage + 1;
      final result = await _repository.getProjects(
        page: nextPage,
        category: state.selectedCategory == 'all' ? null : state.selectedCategory,
        cityId: state.selectedCityId,
      );

      if (result is ResourceSuccess) {
        final paginatedResult = result.data!;

        if (paginatedResult.data.isEmpty) {
          emit(
            state.copyWith(
              status: DeveloperProjectsStatus.loaded,
              hasMore: false,
            ),
          );
          return;
        }

        final allProjects = [...state.projects, ...paginatedResult.data];

        emit(
          state.copyWith(
            projects: allProjects,
            currentPage: paginatedResult.currentPage,
            lastPage: paginatedResult.lastPage,
            hasMore: paginatedResult.hasMore,
            status: DeveloperProjectsStatus.loaded,
          ),
        );
      } else {
        emit(state.copyWith(status: DeveloperProjectsStatus.loaded));
      }
    } catch (e) {
      emit(state.copyWith(status: DeveloperProjectsStatus.loaded));
    }
  }

  Future<void> selectCity(int? cityId) async {
    if (state.selectedCityId == cityId) return;

    try {
      emit(
        state.copyWith(
          status: DeveloperProjectsStatus.loading,
          selectedCityId: cityId,
        ),
      );

      // Fetch projects with category and city filters
      final result = await _repository.getProjects(
        category: state.selectedCategory == 'all' ? null : state.selectedCategory,
        cityId: cityId,
      );

      if (result is ResourceSuccess) {
        final paginatedResult = result.data!;
        
        emit(
          state.copyWith(
            status: paginatedResult.data.isEmpty
                ? DeveloperProjectsStatus.loaded
                : DeveloperProjectsStatus.loaded,
            projects: paginatedResult.data,
            currentPage: paginatedResult.currentPage,
            lastPage: paginatedResult.lastPage,
            hasMore: paginatedResult.hasMore,
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: DeveloperProjectsStatus.error,
            errorMessage: result.message ?? 'حدث خطأ ما',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: DeveloperProjectsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
