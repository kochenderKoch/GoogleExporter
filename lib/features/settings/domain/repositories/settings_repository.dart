import 'package:dartz/dartz.dart';

import '/shared/domain/models/settings/settings_obb_model.dart';
import '/shared/exceptions/http_exception.dart';

/// Defines the contract for the settings repository.
///
/// This abstract class outlines methods that must be implemented
/// to interface with settings data. It serves as a boundary between
/// the domain layer and the data layer of the application.
abstract class SettingsRepository {
  /// Fetches the user settings.
  ///
  /// Returns an [Either] type that wraps a [AppException] on failure,
  /// or a [SettingsComplex] on success.
  Future<Either<AppException, SettingsComplex>> fetchSettings();

  /// Changes the user settings.
  ///
  /// Parameters:
  /// - [newSettings]: The new settings to apply.
  ///
  /// Returns an [Either] type that wraps a [AppException] on failure,
  /// or a [bool] indicating success on success.
  Future<Either<AppException, bool>> changeSettings(
    SettingsComplex newSettings,
  );
}
