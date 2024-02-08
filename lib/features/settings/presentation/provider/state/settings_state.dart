import 'package:equatable/equatable.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_obb_model.dart';

/// Represents the various states that the settings feature can be in.
enum SettingsConcreteState {
  initial,
  loading,
  loaded,
  failure,
  changing,
  fetchedAll,
}

/// A class to represent the state of the settings feature.
///
/// It extends [Equatable] to enable value comparison based on the fields
/// rather than the default reference comparison.
class SettingsState extends Equatable {
  /// The current settings, if available.
  final SettingsComplex? settings;

  /// A flag indicating whether data is present.
  final bool hasData;

  /// Whether the settings are currently being loaded.
  final bool isLoading;

  /// The current state of the settings (e.g., initial, loading, loaded, etc.).
  final SettingsConcreteState state;

  /// An optional message, typically used for errors.
  final String? message;

  /// Constructor for creating a new [SettingsState].
  const SettingsState({
    this.settings,
    this.hasData = false,
    this.isLoading = false,
    this.state = SettingsConcreteState.initial,
    this.message = '',
  });

  /// Named constructor for creating the initial state of [SettingsState].
  const SettingsState.initial({
    this.settings,
    this.hasData = false,
    this.isLoading = false,
    this.state = SettingsConcreteState.initial,
    this.message = '',
  });

  /// A method to copy the current state with optional new values.
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

  /// Override of the toString method for more readable printing.
  @override
  String toString() {
    return '''SettingsState(isLoading:$isLoading, settings: $settings, hasData: $hasData, state: $state, message: $message)''';
  }

  /// A list of properties that will be used to determine whether two instances are equal.
  @override
  List<Object?> get props => [settings, hasData, state, isLoading, message];
}
