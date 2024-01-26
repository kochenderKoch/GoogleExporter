import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/project/domain/providers/project_providers.dart';
import 'package:google_exporter/features/project/domain/repositories/project_repository.dart';
import 'package:google_exporter/features/project/presentation/provider/state/project_state.dart';
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/providers/isar_database_service_provider.dart';

//TODO(kochenderKoch): Implement a method for opening a project-specific database.
final currentProjectProvider =
    StateNotifierProvider.family<CurrentProjectNotifier, ProjectState, int>(
  (ref, projectId) {
    final projectRepository = ref.watch(projectRepositoryProvider);
    final databaseService =
        ref.watch(databaseProjectServiceProvider(projectId.toString()));
    return CurrentProjectNotifier(
        projectRepository, databaseService, projectId);
  },
);

class CurrentProjectNotifier extends StateNotifier<ProjectState> {
  final ProjectRepository projectRepository;
  final int projectId;
  final DatabaseService databaseService;

  CurrentProjectNotifier(
      this.projectRepository, this.databaseService, this.projectId)
      : super(const ProjectState.initial());

  Future<void> loadProject() async {
    state = state.copyWith(isLoading: true);

    final response = await projectRepository.getProjectById(projectId);
    response.fold(
      (failure) => state = state.copyWith(
        state: ProjectConcreteState.failure,
        message: failure.message,
        isLoading: false,
      ),
      (project) => state = state.copyWith(
        projectList: [],
        currentProject: project,
        state: ProjectConcreteState.loaded,
        hasData: true,
        isLoading: false,
      ),
    );
  }

  // Hier können weitere Methoden hinzugefügt werden, um das Projekt zu bearbeiten, zu löschen usw.
}
