import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/project/domain/providers/project_providers.dart';
import 'package:google_exporter/features/project/presentation/provider/state/project_notifier.dart';
import 'package:google_exporter/features/project/presentation/provider/state/project_state.dart';

final projectNotifierProvider = StateNotifierProvider<ProjectNotifier, ProjectState>((ref) {
  final repository = ref.watch(projectRepositoryProvider);
  return ProjectNotifier(repository)..fetchProjects();
});
