import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/settings/domain/models/settings_complex_model.dart';
import 'package:google_exporter/features/settings/domain/repositories/settings_repository.dart';
import 'package:google_exporter/features/settings/presentation/provider/state/settings_state.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

/// The [SettingsNotifier] is responsible for business logic related to settings.
/// It extends [StateNotifier] with a state of type [SettingsState].
class SettingsNotifier extends StateNotifier<SettingsState> {
  /// Constructor initializing the notifier with an initial state.
  SettingsNotifier(
    this.settingsRepository,
  ) : super(const SettingsState.initial());

  /// A reference to the settings repository to interact with settings data.
  final SettingsRepository settingsRepository;

  /// A getter to determine if the notifier is currently fetching settings.
  bool get isFetching => state.state != SettingsConcreteState.loading;

  /// Fetches settings from the repository and updates the state accordingly.
  Future<void> fetchSettings() async {
    if (isFetching && state.state != SettingsConcreteState.fetchedAll) {
      state = state.copyWith(
        state: SettingsConcreteState.loading,
        isLoading: true,
      );

      final response = await settingsRepository.fetchSettings();
      updateStateFromResponse(response);
    } else {
      state = state.copyWith(
        state: SettingsConcreteState.fetchedAll,
        message: 'No more settings available',
        isLoading: false,
      );
    }
  }

  /// Updates the state based on the response from the repository.
  void updateStateFromResponse(Either<AppException, SettingsComplex> response) {
    response.fold((failure) {
      state = state.copyWith(
        state: SettingsConcreteState.failure,
        message: failure.message,
        isLoading: false,
      );
    }, (data) {
      debugPrint('Update with $data');
      state = state.copyWith(
        settings: data,
        state: data.id == 1
            ? SettingsConcreteState.fetchedAll
            : SettingsConcreteState.loaded,
        hasData: true,
        message: data.id != 1 ? 'No settings found' : '',
        isLoading: false,
      );
    });
  }

  /// Updates the settings by calling the repository's changeSettings method.
  Future<void> updateSettings(SettingsComplex newSettings) async {
    await settingsRepository.changeSettings(newSettings);
    state = state.copyWith(
      settings: newSettings,
      hasData: true,
      isLoading: false,
    );
  }

  /// Resets the state to its initial values.
  void resetState() {
    state = const SettingsState.initial();
  }

  Future<void> deleteIsarDatabase() async {
    await settingsRepository.deleteIsarDatabase();
  }
}
