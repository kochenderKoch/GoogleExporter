import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/settings/presentation/provider/settings_state_provider.dart';
import '../l10n/app_localizations.dart';
import '../routes/app_route.dart';

/// The main widget for the GoogleExporter app.
///
/// This widget is responsible for setting up the MaterialApp and configuring
/// the theme, localizations, and routing for the app.
class GoogleExporter extends ConsumerWidget {
  const GoogleExporter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final themeMode = ref.watch(appThemeProvider);
    // ref.read(settingsNotifierProvider.notifier).fetchSettings();
    final state = ref.watch(settingsNotifierProvider);

    return MaterialApp.router(
      title: 'GoogleExporter',
      theme: FlexThemeData.light(
        scheme:
            (state.settings != null) ? state.settings!.theme : FlexScheme.redM3,
        appBarElevation: 2,
        useMaterial3: true,
        typography: Typography.material2021(platform: TargetPlatform.windows),
      ),
      darkTheme: FlexThemeData.dark(
        scheme:
            (state.settings != null) ? state.settings!.theme : FlexScheme.redM3,
        appBarElevation: 2,
        useMaterial3: true,
        typography: Typography.material2021(platform: TargetPlatform.windows),
      ),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: (state.settings != null)
          ? state.settings!.appLocale
          : Locale(
              "${WidgetsBinding.instance.platformDispatcher.locales.first.countryCode}"),
      // themeMode: ThemeMode.values
      //     .firstWhere((element) => element.name == state.settings!.themeMode)
      //_TODO initiales Laden sicherstellen, dass es abgeschlossen ist!
      themeMode: (state.settings != null)
          ? state.settings!.themeMode
          : ThemeMode.system,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
