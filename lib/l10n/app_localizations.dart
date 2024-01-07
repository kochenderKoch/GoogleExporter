import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

/// Configuration for the internalization
class L10n {
  /// List of all supported [Locale]
  static const supportedLocales = [
    Locale('en'),
    Locale('de'),
  ];

  /// List of [localizationsDelegates]
  static const localizationsDelegates = [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
