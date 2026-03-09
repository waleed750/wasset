import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:waseet/features/developer_real_estate/domain/entities/developer_project_entity.dart';
import 'package:waseet/features/developer_real_estate/domain/repositories/developer_real_estate_repository.dart';
import 'package:waseet/res/resource.dart';

part 'project_details_state.dart';

class ProjectDetailsCubit extends Cubit<ProjectDetailsState> {
  ProjectDetailsCubit({
    required DeveloperRealEstateRepository repository,
    required int projectId,
  })  : _repository = repository,
        _projectId = projectId,
        super(const ProjectDetailsState()) {
    init();
  }

  final DeveloperRealEstateRepository _repository;
  final int _projectId;

  Future<void> init() async {
    try {
      emit(state.copyWith(status: ProjectDetailsStatus.loading));

      final result = await _repository.getProjectById(_projectId);

      if (result is ResourceSuccess) {
        final project = result.data;
        
        if (project != null) {
          emit(
            state.copyWith(
              status: ProjectDetailsStatus.loaded,
              project: project,
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: ProjectDetailsStatus.error,
              errorMessage: 'المشروع غير موجود',
            ),
          );
        }
      } else {
        emit(
          state.copyWith(
            status: ProjectDetailsStatus.error,
            errorMessage: result.message ?? 'حدث خطأ ما',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: ProjectDetailsStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
