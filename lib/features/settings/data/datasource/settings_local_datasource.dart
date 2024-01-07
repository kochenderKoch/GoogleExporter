import 'package:dartz/dartz.dart';
import 'package:google_exporter/features/settings/domain/mapper/settings_mapper.dart';
import 'package:google_exporter/features/settings/domain/models/settings_complex_model.dart';
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';
import 'package:isar/isar.dart';

// ignore: one_member_abstracts
abstract class SettingsDatasource {
  Future<Either<AppException, SettingsComplex>> fetchSettings();
  Future<Either<AppException, bool>> changeSettings(
    SettingsComplex newSettings,
  );
}

class SettingsLocalDatasource extends SettingsDatasource {
  SettingsLocalDatasource(this.databaseService);
  final DatabaseService databaseService;

  @override
  Future<Either<AppException, SettingsComplex>> fetchSettings() async {
    final isar = await databaseService.db;
    final dataset = await isar.settings.where().findAll();
    //_TODO: Falls noch nicht erstellt, dann erstelle
    final data =
        dataset.isEmpty ? Settings('en', 'amber', 'light', 1) : dataset.first;
    return Right(SettingsMapper.toSettingsComplex(data));
  }

  @override
  Future<Either<AppException, bool>> changeSettings(
    SettingsComplex newSettings,
  ) async {
    final settings = SettingsMapper.toSettings(newSettings);
    final isar = await databaseService.db;
    await isar.writeTxn(() async {
      await isar.settings.put(settings);
    });
    return const Right(true);
  }
}
