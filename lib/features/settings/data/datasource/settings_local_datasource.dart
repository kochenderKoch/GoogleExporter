import 'package:dartz/dartz.dart';
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_obb_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';
import 'package:objectbox/objectbox.dart';

/// The abstraction for settings data retrieval and update functionality.
///
/// This abstract class defines the contract for fetching and changing
/// user settings from a data source.
abstract class SettingsDatasource {
  /// Fetches the user settings.
  ///
  /// Returns a [Either] wrapping an [AppException] in case of failure,
  /// or a [SettingsComplex] object in case of success.
  Future<Either<AppException, SettingsComplex>> fetchSettings();

  /// Changes the user settings.
  ///
  /// Accepts a [SettingsComplex] object representing the new settings to be applied.
  ///
  /// Returns a [Either] wrapping an [AppException] in case of failure,
  /// or a [bool] indicating success.
  Future<Either<AppException, bool>> changeSettings(
    SettingsComplex newSettings,
  );
}

/// A concrete implementation of [SettingsDatasource] using a local database.
///
/// This class interacts with a local database service to fetch and update
/// user settings.
class SettingsLocalDatasource extends SettingsDatasource {
  /// Constructs the datasource with a reference to [DatabaseService].
  SettingsLocalDatasource(this.databaseService);

  /// The service responsible for database interactions.
  final DatabaseService databaseService;

  /// Fetches the user settings from the local database.
  ///
  /// If no settings are found, default settings are created.
  /// Returns the settings wrapped in a [Right] if successful, or an
  /// [AppException] wrapped in a [Left] in case of failure.
  @override
  Future<Either<AppException, SettingsComplex>> fetchSettings() async {
    final store = await databaseService.db as Store;
    final dataset = await store.box<SettingsComplex>().getAll();
    final data = dataset.isEmpty ? SettingsComplex.initial() : dataset.first;
    return Right(data);
  }

  /// Updates the user settings in the local database with [newSettings].
  ///
  /// Returns a [Right] with [true] if the operation is successful.
  /// If the operation fails, it returns a [Left] with an [AppException].
  @override
  Future<Either<AppException, bool>> changeSettings(
    SettingsComplex newSettings,
  ) async {
    final store = await databaseService.db as Store;
    final result = store.box<SettingsComplex>().put(newSettings);
    if (result == 0) {
      return Left(AppException(
          message: 'Failed to update settings',
          statusCode: 101,
          identifier: "FailedUpdateSettingsDatabase"));
    }
    return const Right(true);
  }
}
