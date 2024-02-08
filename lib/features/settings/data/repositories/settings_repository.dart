import 'package:dartz/dartz.dart';
import 'package:google_exporter/features/settings/data/datasource/settings_local_datasource.dart';
import 'package:google_exporter/features/settings/domain/repositories/settings_repository.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_obb_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

/// An implementation of the [SettingsRepository] interfacing with a local data source.
///
/// This class defines the methods for interacting with settings data
/// using a local data source. It acts as a bridge between the domain layer
/// and the data layer, ensuring that the domain layer remains agnostic
/// of the data source implementation.
class SettingsRepositoryImpl extends SettingsRepository {
  /// Constructs the repository with a reference to a [SettingsDatasource].
  SettingsRepositoryImpl(this.settingsDatasource);

  /// The data source that this repository interacts with.
  final SettingsDatasource settingsDatasource;

  /// Requests to change the user settings.
  ///
  /// Delegates the operation to the data source and returns the result.
  ///
  /// Parameters:
  /// - [newSettings]: The new settings to be applied.
  ///
  /// Returns a [Either] wrapping an [AppException] in case of failure,
  /// or a [bool] indicating success.
  @override
  Future<Either<AppException, bool>> changeSettings(
    SettingsComplex newSettings,
  ) {
    return settingsDatasource.changeSettings(newSettings);
  }

  /// Fetches the user settings.
  ///
  /// Delegates the operation to the data source and returns the result.
  ///
  /// Returns a [Either] wrapping an [AppException] in case of failure,
  /// or a [SettingsComplex] object in case of success.
  @override
  Future<Either<AppException, SettingsComplex>> fetchSettings() {
    return settingsDatasource.fetchSettings();
  }
}
