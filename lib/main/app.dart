import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/settings/presentation/provider/settings_state_provider.dart';
import 'package:google_exporter/l10n/app_localizations.dart';
import 'package:google_exporter/routes/app_route.dart';

class GoogleExporter extends ConsumerWidget {
  const GoogleExporter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final themeMode = ref.watch(appThemeProvider);
    // ref.read(settingsNotifierProvider.notifier).fetchSettings();
    final state = ref.watch(settingsNotifierProvider);

    return MaterialApp.router(
      title: 'GoogleExporter',
      theme: FlexThemeData.light(
        scheme: state.settings!.theme,
        appBarElevation: 2,
        useMaterial3: true,
        typography: Typography.material2021(platform: TargetPlatform.windows),
      ),
      darkTheme: FlexThemeData.dark(
        scheme: state.settings!.theme,
        appBarElevation: 2,
        useMaterial3: true,
        typography: Typography.material2021(platform: TargetPlatform.windows),
      ),
      localizationsDelegates: L10n.localizationsDelegates,
      supportedLocales: L10n.supportedLocales,
      locale: state.settings!.appLocal,
      // themeMode: ThemeMode.values
      //     .firstWhere((element) => element.name == state.settings!.themeMode),
      // TODO initiales Laden sicherstellen, dass es abgeschlossen ist!
      themeMode: state.settings!.themeMode,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
