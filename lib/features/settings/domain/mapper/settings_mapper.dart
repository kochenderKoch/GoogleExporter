import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_exporter/features/settings/domain/models/settings_complex_model.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_model.dart';

class SettingsMapper {
  static Settings toSettings(SettingsComplex settingsComplex) {
    return Settings(
      settingsComplex.appLocal.languageCode,
      settingsComplex.theme.name,
      settingsComplex.themeMode.name,
      settingsComplex.id ?? 1,
    );
  }

  static SettingsComplex toSettingsComplex(Settings settings) {
    return SettingsComplex(
      Locale(settings.appLocal),
      FlexScheme.values.firstWhere((element) => element.name == settings.theme),
      ThemeMode.values
          .firstWhere((element) => element.name == settings.themeMode),
      settings.id,
    );
  }
}
