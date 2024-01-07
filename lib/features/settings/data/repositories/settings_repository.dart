import 'package:dartz/dartz.dart';
import 'package:google_exporter/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:google_exporter/features/settings/domain/models/settings_complex_model.dart';
import 'package:google_exporter/features/settings/domain/repositories/settings_repository.dart';

import 'package:google_exporter/shared/exceptions/http_exception.dart';

class SettingsRepositoryImpl extends SettingsRepository {
  SettingsRepositoryImpl(this.settingsDatasource);
  final SettingsDatasource settingsDatasource;

  @override
  Future<Either<AppException, bool>> changeSettings(
    SettingsComplex newSettings,
  ) {
    return settingsDatasource.changeSettings(newSettings);
  }

  @override
  Future<Either<AppException, SettingsComplex>> fetchSettings() {
    return settingsDatasource.fetchSettings();
  }
}
