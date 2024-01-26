import 'package:equatable/equatable.dart';
import 'package:google_exporter/shared/domain/models/projects/project_model.dart';

enum ProjectConcreteState {
  initial,
  loading,
  loaded,
  adding,
  failure,
  fetchedAllProject,
}

class ProjectState extends Equatable {
  const ProjectState({
    this.projectList = const [],
    this.currentProject = null,
    this.title = '',
    this.hasData = false,
    this.isLoading = false,
    this.state = ProjectConcreteState.initial,
    this.message = '',
  });
  const ProjectState.initial({
    this.projectList = const [],
    this.currentProject = null,
    this.title = '',
    this.hasData = false,
    this.isLoading = false,
    this.state = ProjectConcreteState.initial,
    this.message = '',
  });
  final List<Project> projectList;
  final String title;
  final bool hasData;
  final bool isLoading;
  final ProjectConcreteState state;
  final String message;
  final Project? currentProject;

  ProjectState copyWith({
    List<Project>? projectList,
    Project? currentProject,
    String? title,
    bool? hasData,
    ProjectConcreteState? state,
    bool? isLoading,
    String? message,
  }) {
    return ProjectState(
      isLoading: isLoading ?? this.isLoading,
      currentProject: currentProject ?? this.currentProject,
      projectList: projectList ?? this.projectList,
      title: title ?? this.title,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''ProjectState(isLoading:$isLoading, projectList: ${projectList.length}, currentProject: $currentProject, title:$title, hasData: $hasData, state: $state, message: $message)''';
  }

  @override
  List<Object?> get props =>
      [title, projectList, currentProject, hasData, state, message];
}
