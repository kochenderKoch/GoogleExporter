import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/features/settings/domain/models/settings_complex_model.dart';
import 'package:google_exporter/features/settings/domain/repositories/settings_repository.dart';
import 'package:google_exporter/features/settings/presentation/provider/state/settings_state.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier(
    this.settingsRepository,
  ) : super(const SettingsState.initial());
  final SettingsRepository settingsRepository;

  bool get isFetching => state.state != SettingsConcreteState.loading;

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
        message: 'No more notices available',
        isLoading: false,
      );
    }
  }

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

  Future<void> updateSettings(SettingsComplex newSettings) async {
    await settingsRepository.changeSettings(newSettings);
    state = state.copyWith(
      settings: newSettings,
      hasData: true,
      isLoading: false,
    );
  }

  void resetState() {
    state = const SettingsState.initial();
  }
}
