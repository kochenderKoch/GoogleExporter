import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:google_exporter/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:google_exporter/features/settings/data/repositories/settings_repository.dart';
import 'package:google_exporter/features/settings/domain/repositories/settings_repository.dart';
import 'package:google_exporter/shared/data/local/isar_database_service.dart';
import 'package:google_exporter/shared/domain/providers/isar_database_service_provider.dart';

final settingsDatasourceProvider =
    Provider.family<SettingsDatasource, IsarDatabaseService>(
  (_, databaseService) => SettingsLocalDatasource(databaseService),
);

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  final databaseService = ref.watch(databaseServiceProvider);
  final datasource = ref.watch(settingsDatasourceProvider(databaseService));
  final respository = SettingsRepositoryImpl(datasource);

  return respository;
});
