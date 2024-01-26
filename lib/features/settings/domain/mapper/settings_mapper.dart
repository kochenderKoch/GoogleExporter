import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_exporter/features/settings/domain/models/settings_complex_model.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_model.dart';

/// A utility class that provides methods to map settings data
/// between different representations.
///
/// It facilitates the conversion between the [SettingsComplex] domain model
/// and the [Settings] data model.
class SettingsMapper {
  /// Converts a [SettingsComplex] object to a [Settings] object.
  ///
  /// Parameters:
  /// - [settingsComplex]: The complex settings model to convert.
  ///
  /// Returns a [Settings] object that represents the simplified settings data.
  static Settings toSettings(SettingsComplex settingsComplex) {
    return Settings(
      settingsComplex.appLocale.languageCode,
      settingsComplex.theme.name,
      settingsComplex.themeMode.name,
      settingsComplex.id ?? 1,
    );
  }

  /// Converts a [Settings] object to a [SettingsComplex] object.
  ///
  /// Parameters:
  /// - [settings]: The simplified settings model to convert.
  ///
  /// Returns a [SettingsComplex] object that represents the detailed settings data.
  static SettingsComplex toSettingsComplex(Settings settings) {
    return SettingsComplex(
      Locale(settings.appLocale),
      FlexScheme.values.firstWhere((element) => element.name == settings.theme),
      ThemeMode.values
          .firstWhere((element) => element.name == settings.themeMode),
      settings.id,
    );
  }
}
