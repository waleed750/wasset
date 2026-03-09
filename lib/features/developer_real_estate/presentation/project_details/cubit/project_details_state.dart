part of 'project_details_cubit.dart';

enum ProjectDetailsStatus {
  initial,
  loading,
  loaded,
  error,
}

class ProjectDetailsState extends Equatable {
  const ProjectDetailsState({
    this.status = ProjectDetailsStatus.initial,
    this.project,
    this.errorMessage = '',
  });

  final ProjectDetailsStatus status;
  final DeveloperProjectEntity? project;
  final String errorMessage;

  @override
  List<Object?> get props => [status, project, errorMessage];

  ProjectDetailsState copyWith({
    ProjectDetailsStatus? status,
    DeveloperProjectEntity? project,
    String? errorMessage,
  }) {
    return ProjectDetailsState(
      status: status ?? this.status,
      project: project ?? this.project,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
