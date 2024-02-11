import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/project/domain/repositories/project_repository.dart';
import '/features/project/presentation/provider/state/project_state.dart';
import '/shared/domain/models/projects/project_model.dart';
import '/shared/exceptions/http_exception.dart';

class ProjectNotifier extends StateNotifier<ProjectState> {
  ProjectNotifier(
    this.projectRepository,
  ) : super(const ProjectState.initial());

  final ProjectRepository projectRepository;

  bool get isFetching => state.state != ProjectConcreteState.loading;

  Future<void> addProject(Project newProject) async {
    final addResponse = await projectRepository.addProject(newProject);
    addResponse.fold(
      (l) => state = state.copyWith(
        state: ProjectConcreteState.failure,
        message: l.message,
        isLoading: false,
      ),
      (r) async {
        state = state.copyWith(
          state: ProjectConcreteState.loaded,
          isLoading: false,
          hasData: true,
        );
        await fetchProjects();
      },
    );
  }

  Future<void> fetchProjects() async {
    if (isFetching && state.state != ProjectConcreteState.fetchedAllProject) {
      state = state.copyWith(
        state: ProjectConcreteState.loading,
        isLoading: true,
      );

      final response = await projectRepository.fetchProjects();

      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: ProjectConcreteState.fetchedAllProject,
        message: 'No more projects available',
        hasData: false,
        isLoading: false,
      );
    }
  }

  Future<void> updateNotice(Project updatedProject) async {
    state = state.copyWith(
      state: ProjectConcreteState.loading,
      isLoading: true,
      hasData: false,
    );

    final updateResponse =
        await projectRepository.updateProject(updatedProject);
    updateResponse.fold(
      (l) => state = state.copyWith(
        state: ProjectConcreteState.failure,
        message: l.message,
        isLoading: false,
      ),
      (r) async {
        state = state.copyWith(
          state: ProjectConcreteState.loaded,
          isLoading: false,
          hasData: true,
        );
        await fetchProjects();
      },
    );
  }

  void updateStateFromResponse(Either<AppException, List<Project>> response) {
    response.fold((failure) {
      state = state.copyWith(
        state: ProjectConcreteState.failure,
        message: failure.message,
        isLoading: false,
      );
    }, (data) {
      state = state.copyWith(
        projectList: data,
        state: data.length > 1
            ? ProjectConcreteState.fetchedAllProject
            : ProjectConcreteState.loaded,
        hasData: data.isNotEmpty,
        message: data.isEmpty ? 'No projects found' : '',
        isLoading: false,
      );
    });
  }

  void resetState() {
    state = const ProjectState.initial();
  }
}
