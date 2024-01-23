import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

/// The [SettingsComplex] class represents complex settings for the application.
class SettingsComplex {
  /// Constructor for creating a [SettingsComplex] instance.
  SettingsComplex(this.appLocale, this.theme, this.themeMode, this.id);

  /// An identifier for the settings, which may be useful for storing multiple settings.
  int? id;

  /// The locale of the application.
  Locale appLocale;

  /// The theme scheme used by the application utilizing FlexColorScheme.
  FlexScheme theme;

  /// The theme mode (light, dark, system) of the application.
  ThemeMode themeMode;

  /// Creates a copy of the current [SettingsComplex] instance with the given overrides.
  SettingsComplex copyWith({
    int? id,
    Locale? appLocale,
    FlexScheme? theme,
    ThemeMode? themeMode,
  }) {
    return SettingsComplex(
      appLocale ?? this.appLocale,
      theme ?? this.theme,
      themeMode ?? this.themeMode,
      id ?? this.id,
    );
  }
}
