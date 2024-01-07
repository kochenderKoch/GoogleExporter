import 'package:equatable/equatable.dart';
import 'package:google_exporter/features/settings/domain/models/settings_complex_model.dart';

enum SettingsConcreteState {
  initial,
  loading,
  loaded,
  failure,
  changing,
  fetchedAll
}

class SettingsState extends Equatable {
  const SettingsState({
    this.settings,
    this.hasData = false,
    this.isLoading = false,
    this.state = SettingsConcreteState.initial,
    this.message = '',
  });
  const SettingsState.initial({
    this.settings,
    this.hasData = false,
    this.isLoading = false,
    this.state = SettingsConcreteState.initial,
    this.message = '',
  });

  final bool isLoading;
  final bool hasData;
  final SettingsConcreteState state;
  final SettingsComplex? settings;
  final String? message;

  SettingsState copyWith({
    SettingsComplex? settings,
    bool? hasData,
    SettingsConcreteState? state,
    bool? isLoading,
    String? message,
  }) {
    return SettingsState(
      isLoading: isLoading ?? this.isLoading,
      settings: settings ?? this.settings,
      hasData: hasData ?? this.hasData,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''SettingsState(isLoading:$isLoading, settings: $settings, hasData: $hasData, state: $state, message: $message)''';
  }

  @override
  List<Object?> get props => [settings, hasData, state, message];
}
