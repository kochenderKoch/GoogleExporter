import 'package:dartz/dartz.dart';
import 'package:google_exporter/features/settings/domain/models/settings_complex_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

// ignore: one_member_abstracts
abstract class SettingsRepository {
  Future<Either<AppException, SettingsComplex>> fetchSettings();
  Future<Either<AppException, bool>> changeSettings(
      SettingsComplex newSettings);
}
