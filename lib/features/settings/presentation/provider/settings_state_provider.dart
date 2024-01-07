import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/settings/domain/providers/settings_providers.dart';

import 'package:google_exporter/features/settings/presentation/provider/state/settings_notifier.dart';
import 'package:google_exporter/features/settings/presentation/provider/state/settings_state.dart';

final settingsNotifierProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  final repository = ref.watch(settingsRepositoryProvider);
  return SettingsNotifier(repository)..fetchSettings();
});
