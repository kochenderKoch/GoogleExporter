import 'dart:io';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';

import '/features/settings/presentation/provider/settings_state_provider.dart';
import '/features/settings/presentation/provider/state/settings_state.dart';
import '/l10n/app_localizations.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(settingsNotifierProvider);
    //debugPrint('themeMode: ${state.settings!.themeMode}');
    if (state.state != SettingsConcreteState.loaded &&
        state.state != SettingsConcreteState.fetchedAll) {
      return Column(
        children: [
          const CircularProgressIndicator(),
          ElevatedButton(
            onPressed: () async {
              exit(0);
            },
            child: Text("Datenbank löschen"),
          ),
        ],
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: SettingsList(
            lightTheme: SettingsThemeData(
              settingsSectionBackground: Theme.of(context).hoverColor,
              settingsListBackground: Theme.of(context).colorScheme.background,
            ),
            darkTheme: SettingsThemeData(
              settingsListBackground: Theme.of(context).colorScheme.background,
            ),
            sections: [
              SettingsSection(
                title: Text(AppLocalizations.of(context).generalSettings),
                tiles: [
                  SettingsTile(
                    leading: const Icon(Icons.color_lens),
                    title: Text(AppLocalizations.of(context).themeMode),
                    value: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: ToggleButtons(
                        onPressed: (int index) {
                          switch (index) {
                            case 0:
                              ref
                                  .read(settingsNotifierProvider.notifier)
                                  .updateSettings(
                                    state.settings!
                                        .copyWith(themeMode: ThemeMode.light),
                                  );

                            case 1:
                              ref
                                  .read(settingsNotifierProvider.notifier)
                                  .updateSettings(
                                    state.settings!
                                        .copyWith(themeMode: ThemeMode.dark),
                                  );

                            case 2:
                              ref
                                  .read(settingsNotifierProvider.notifier)
                                  .updateSettings(
                                    state.settings!
                                        .copyWith(themeMode: ThemeMode.system),
                                  );
                          }
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        selectedBorderColor: Colors.blue[700],
                        selectedColor: Colors.white,
                        fillColor: Colors.blue[200],
                        color: Colors.blue[400],
                        isSelected: [
                          state.settings!.themeMode == ThemeMode.light,
                          state.settings!.themeMode == ThemeMode.dark,
                          state.settings!.themeMode == ThemeMode.system,
                        ],
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.light_mode,
                                size: 15,
                              ),
                              Text(
                                ' ${AppLocalizations.of(context).lightMode} ',
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.dark_mode,
                                size: 15,
                              ),
                              Text(
                                ' ${AppLocalizations.of(context).darkMode} ',
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.settings_system_daydream,
                                size: 15,
                              ),
                              Text(
                                ' ${AppLocalizations.of(context).systemMode} ',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.language),
                    title: Text(AppLocalizations.of(context).colorSchema),
                    value: DropdownButton<String>(
                      value: state.settings!.theme.name,
                      onChanged: (String? value) {
                        ref
                            .read(settingsNotifierProvider.notifier)
                            .updateSettings(
                              state.settings!.copyWith(
                                theme: FlexScheme.values.firstWhere(
                                  (element) => element.name == value,
                                ),
                              ),
                            );
                      },
                      items: FlexScheme.values
                          .map((e) => e.name)
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SettingsTile(
                    leading: const Icon(Icons.language),
                    title: Text(AppLocalizations.of(context).language),
                    value: DropdownButton<String>(
                      value: state.settings!.appLocale.languageCode,
                      onChanged: (String? value) {
                        if (L10n.supportedLocales
                            .map((e) => e.languageCode)
                            .contains(value)) {
                          ref
                              .read(settingsNotifierProvider.notifier)
                              .updateSettings(
                                state.settings!.copyWith(
                                  appLocale: Locale(value!),
                                ),
                              );
                        }
                      },
                      items: L10n.supportedLocales
                          .map((e) => e.languageCode)
                          .toList()
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SettingsSection(
                title: Text("Debug"),
                tiles: [
                  SettingsTile.navigation(
                    title: Text("Datenbank löschen"),
                    onPressed: (context) async {
                      exit(0);
                    },
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ],
              ),
              SettingsSection(
                title: Text(AppLocalizations.of(context).otherSettings),
                tiles: [
                  SettingsTile.navigation(
                    title: Text(AppLocalizations.of(context).openSource),
                    onPressed: (context) {},
                    trailing: const Icon(Icons.arrow_right),
                  ),
                  SettingsTile.navigation(
                    title: Text(AppLocalizations.of(context).privacy_policy),
                    onPressed: (context) {},
                    trailing: const Icon(Icons.arrow_right),
                  ),
                  SettingsTile.navigation(
                    title: Text(AppLocalizations.of(context).about),
                    onPressed: (context) {},
                    trailing: const Icon(Icons.arrow_right),
                  ),
                ],
              ),
              SettingsSection(
                tiles: [
                  SettingsTile(
                    title: Text(AppLocalizations.of(context).aboutThisApp),
                    description: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AppName',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),

                        Text(
                          'App-Version: VERSION, Build-Version: BUILDVERSION',
                        ),

                        //Text('''Build: ${_packageInfo.buildSignature}'''),
                        Text(
                          'Developed by kochenderKoch',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
