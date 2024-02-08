import 'package:objectbox/objectbox.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_exporter/objectbox.g.dart';

@Entity()
class SettingsComplex {
  int id = 0;

  // Konvertiere Locale zu einem String für die Speicherung
  String appLocaleString;

  // Konvertiere FlexScheme zu einem String für die Speicherung
  String themeString;

  // Konvertiere ThemeMode zu einem int für die Speicherung
  int themeModeInt;

  // Nicht gespeichert in ObjectBox, nur zur Laufzeit verwendet
  @Transient()
  Locale get appLocale => Locale(
      appLocaleString.split('_')[0],
      appLocaleString.split('_').length > 1
          ? appLocaleString.split('_')[1]
          : '');
  set appLocale(Locale locale) =>
      appLocaleString = '${locale.languageCode}_${locale.countryCode ?? ""}';

  @Transient()
  FlexScheme get theme => FlexScheme.values.byName(themeString);
  set theme(FlexScheme scheme) => themeString = scheme.name;

  @Transient()
  ThemeMode get themeMode => ThemeMode.values[themeModeInt];
  set themeMode(ThemeMode mode) => themeModeInt = mode.index;

  SettingsComplex({
    this.id = 0,
    required this.appLocaleString,
    required this.themeString,
    required this.themeModeInt,
  });

  SettingsComplex.initial(
      {this.id = 0,
      this.appLocaleString = "",
      this.themeModeInt = 0,
      this.themeString = ""}) {
    this.appLocale = Locale("en");
    this.theme = FlexScheme.amber;
    this.themeMode = ThemeMode.system;
  }

  // Factory-Methode für die Erstellung einer SettingsComplex Instanz
  factory SettingsComplex.create({
    int? id,
    required Locale appLocale,
    required FlexScheme theme,
    required ThemeMode themeMode,
  }) {
    return SettingsComplex(
      id: id ?? 0,
      appLocaleString:
          '${appLocale.languageCode}_${appLocale.countryCode ?? ""}',
      themeString: theme.name,
      themeModeInt: themeMode.index,
    );
  }

  SettingsComplex copyWith({
    int? id,
    Locale? appLocale,
    FlexScheme? theme,
    ThemeMode? themeMode,
  }) {
    return SettingsComplex(
      id: id ?? this.id,
      appLocaleString: appLocale != null
          ? '${appLocale.languageCode}_${appLocale.countryCode ?? ""}'
          : this.appLocaleString,
      themeString: theme?.name ?? this.themeString,
      themeModeInt: themeMode?.index ?? this.themeModeInt,
    );
  }
}
