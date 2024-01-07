import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/dashboard/data/datasource/dashboard_local_datasource.dart';
import 'package:google_exporter/features/dashboard/data/repositories/dashboard_repository.dart';
import 'package:google_exporter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:google_exporter/shared/data/local/isar_database_service.dart';
import 'package:google_exporter/shared/domain/providers/isar_database_service_provider.dart';

final dashboardDatasourceProvider =
    Provider.family<DashboardDatasource, IsarDatabaseService>(
  (_, databaseService) => DashboardLocalDatasource(databaseService),
);

final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  final datasource = ref.watch(dashboardDatasourceProvider(databaseService));
  final respository = DashboardRepositoryImpl(datasource);

  return respository;
});
