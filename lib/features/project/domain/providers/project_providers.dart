import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/project/data/datasource/project_local_datasource.dart';
import 'package:google_exporter/features/project/data/repositories/project_repositoriy.dart';
import 'package:google_exporter/features/project/domain/repositories/project_repository.dart';
import 'package:google_exporter/shared/data/local/objectbox_database_service.dart';
import 'package:google_exporter/shared/domain/providers/objectbox_database_service_provider.dart';

final projectDatasourceProvider = Provider.family<ProjectDatasource, ObjectBoxDatabaseService>(
  (_, databaseService) => ProjectLocalDatasource(databaseService),
);

final projectRepositoryProvider = Provider<ProjectRepository>((ref) {
  final databaseService = ref.watch(generalDatabaseServiceProvider);
  final datasource = ref.watch(projectDatasourceProvider(databaseService));
  final respository = ProjectRepositoryImpl(datasource);

  return respository;
});
