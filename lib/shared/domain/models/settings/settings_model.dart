import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:isar/isar.dart';

part 'settings_model.g.dart';

@collection
@JsonSerializable()
class Settings {
  Settings(this.appLocal, this.theme, this.themeMode, this.id);
  factory Settings.fromJson(Map<String, dynamic> json) =>
      _$SettingsFromJson(json);

  Id id = 1;
  String appLocal = 'en';
  String theme = FlexScheme.amber.name;
  String themeMode = ThemeMode.system.name;

  Map<String, dynamic> toJson() => _$SettingsToJson(this);
}
