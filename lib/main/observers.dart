import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Observers for monitoring changes in Riverpod providers.
///
/// This class extends the [ProviderObserver] and logs the changes
/// when a provider is updated or disposed.
class Observers extends ProviderObserver {
  /// Called when a provider is updated with a new value.
  ///
  /// Logs the provider's name and the new value it has been updated with.
  /// If the provider's name is not set, it logs the runtime type of the provider.
  ///
  /// Parameters:
  /// - [provider]: The provider that was updated.
  /// - [previousValue]: The previous value of the provider before the update.
  /// - [newValue]: The new value the provider was updated with.
  /// - [container]: The provider container in which the provider is present.
  @override
  void didUpdateProvider(
    ProviderBase<dynamic> provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    log('''
{
 "provider": "${provider.name ?? provider.runtimeType}",
 "newValue": "$newValue"
}''');
  }

  /// Called when a provider is disposed.
  ///
  /// Logs the provider's name and a disposed message indicating that the provider
  /// has been disposed. If the provider's name is not set, it logs the runtime type
  /// of the provider.
  ///
  /// Parameters:
  /// - [provider]: The provider that was disposed.
  /// - [container]: The provider container in which the provider was present.
  @override
  void didDisposeProvider(
    ProviderBase<dynamic> provider,
    ProviderContainer container,
  ) {
    log('''
{
 "provider": "${provider.name ?? provider.runtimeType}",
 "newValue": "disposed"
}''');
    super.didDisposeProvider(provider, container);
  }
}
