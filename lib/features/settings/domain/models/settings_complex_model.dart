import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class SettingsComplex {
  SettingsComplex(this.appLocal, this.theme, this.themeMode, this.id);

  int? id;
  Locale appLocal;
  FlexScheme theme;
  ThemeMode themeMode;

  SettingsComplex copyWith({
    int? id,
    Locale? appLocal,
    FlexScheme? theme,
    ThemeMode? themeMode,
  }) {
    return SettingsComplex(
      appLocal ?? this.appLocal,
      theme ?? this.theme,
      themeMode ?? this.themeMode,
      id ?? this.id,
    );
  }
}
