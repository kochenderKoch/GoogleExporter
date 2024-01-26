import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
@JsonSerializable()
class Settings {
  Settings(this.appLocale, this.theme, this.themeMode, this.id);

  Settings.initial({
    this.appLocale = "en",
    this.theme = "amber",
    this.themeMode = "system",
    this.id = 1,
  });

  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Id id = 1;
  String appLocale = 'en';
  String theme = FlexScheme.amber.name;
  String themeMode = ThemeMode.system.name;

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
