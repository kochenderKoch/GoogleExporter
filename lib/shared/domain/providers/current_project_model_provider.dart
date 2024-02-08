import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/project/domain/providers/project_providers.dart';
import 'package:google_exporter/features/project/domain/repositories/project_repository.dart';
import 'package:google_exporter/shared/data/local/local.dart';
import 'package:google_exporter/shared/domain/models/projects/project_model.dart';
import 'package:google_exporter/shared/domain/providers/isar_database_service_provider.dart';

class CurrentProjectState {
  final Project? project;

  CurrentProjectState({this.project});

  // Kopiermethode zum Aktualisieren des Zustands
  CurrentProjectState copyWith({Project? project}) {
    return CurrentProjectState(project: project ?? this.project);
  }
}

class CurrentProjectNotifier extends StateNotifier<CurrentProjectState> {
  final ProjectRepository projectRepository;
  late final DatabaseService db;

  CurrentProjectNotifier(this.projectRepository) : super(CurrentProjectState());

  Future<void> setProject(int projectId) async {
    try {
      final project = await projectRepository.getProjectById(projectId);
      debugPrint("sP: $project");
      project.fold((l) => null, (r) {
        state = CurrentProjectState(project: r);
      });
    } catch (e) {
      // Fehlerbehandlung
      print('Failed to set project: $e');
    }
  }

  // Weitere Methoden, wie zum Beispiel das Projekt löschen
  void clearProject() {
    state = CurrentProjectState();
  }
}

final currentProjectProvider =
    StateNotifierProvider<CurrentProjectNotifier, CurrentProjectState>(
  (ref) {
    final projectRepository = ref.watch(projectRepositoryProvider);
    return CurrentProjectNotifier(projectRepository);
  },
);

final dynamicDatabaseProvider = Provider<DatabaseService?>((ref) {
  final currentProjectState = ref.watch(currentProjectProvider);
  final currentProject = currentProjectState.project;

  // Wenn kein Projekt ausgewählt ist, könnte ein Standard-DatabaseService zurückgegeben werden
  // oder es könnte ein Fehler geworfen werden, je nach Anwendungslogik
  if (currentProject == null) {
    //throw UnimplementedError('Kein Projekt ausgewählt');
    return null;
  }

  // Verwenden Sie den `databaseProvider` mit dem aktuell ausgewählten Projekt
  return ref.watch(databaseProjectServiceProvider(currentProject.path));
});
