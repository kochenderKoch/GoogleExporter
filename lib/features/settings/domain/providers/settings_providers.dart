import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:google_exporter/features/settings/data/repositories/settings_repository.dart';
import 'package:google_exporter/features/settings/domain/repositories/settings_repository.dart';
import 'package:google_exporter/shared/data/local/objectbox_database_service.dart';
import 'package:google_exporter/shared/domain/providers/objectbox_database_service_provider.dart';

/// A provider for creating [SettingsDatasource] given an [ObjectBoxDatabaseService].
///
/// It uses the family modifier to create a new instance of the data source
/// for each [ObjectBoxDatabaseService] provided.
final settingsDatasourceProvider = Provider.family<SettingsDatasource, ObjectBoxDatabaseService>(
  (_, databaseService) => SettingsLocalDatasource(databaseService),
);

/// A provider for creating [SettingsRepository].
///
/// It watches for changes in [generalDatabaseServiceProvider] and [settingsDatasourceProvider],
/// and when either updates, it will create a new [SettingsRepositoryImpl].
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final databaseService = ref.watch(generalDatabaseServiceProvider);
  final datasource = ref.watch(settingsDatasourceProvider(databaseService));
  final repository = SettingsRepositoryImpl(datasource);

  return repository;
});
