import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/features/settings/domain/providers/settings_providers.dart';
import '/features/settings/presentation/provider/state/settings_notifier.dart';
import '/features/settings/presentation/provider/state/settings_state.dart';

/// A provider that creates and provides a [SettingsNotifier].
///
/// It watches the [settingsRepositoryProvider] and creates a new instance
/// of [SettingsNotifier] with the repository. Upon creation, it immediately
/// invokes `fetchSettings` to retrieve the current settings.
final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repository)..fetchSettings();
});
