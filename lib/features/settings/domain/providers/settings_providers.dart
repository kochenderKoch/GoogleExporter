import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:google_exporter/features/settings/data/repositories/settings_repository.dart';
import 'package:google_exporter/features/settings/domain/repositories/settings_repository.dart';
import 'package:google_exporter/shared/data/local/isar_database_service.dart';
import 'package:google_exporter/shared/domain/providers/isar_database_service_provider.dart';

/// A provider for creating [SettingsDatasource] given an [IsarDatabaseService].
///
/// It uses the family modifier to create a new instance of the data source
/// for each [IsarDatabaseService] provided.
final settingsDatasourceProvider = Provider.family<SettingsDatasource, IsarDatabaseService>(
  (_, databaseService) => SettingsLocalDatasource(databaseService),
);

/// A provider for creating [SettingsRepository].
///
/// It watches for changes in [databaseServiceProvider] and [settingsDatasourceProvider],
/// and when either updates, it will create a new [SettingsRepositoryImpl].
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  final datasource = ref.watch(settingsDatasourceProvider(databaseService));
  final repository = SettingsRepositoryImpl(datasource);

  return repository;
});
