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
    /// The delegate for the generated localized messages of the app
    AppLocalizations.delegate,

    /// Delegates for the default Material widgets
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ];
}
