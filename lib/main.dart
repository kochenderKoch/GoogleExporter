import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main/app.dart';
import 'main/app_env.dart';
import 'main/observers.dart';

/// Entry point of the application for the production environment.
/// Calls [mainCommon] with [AppEnvironment.PROD] as an argument.
void main() => mainCommon(AppEnvironment.PROD);

/// Common main function that is used to initialize the app with a given [environment].
///
/// This method sets up global configurations and initializes necessary services before
/// running the app.
///
/// - [environment]: The [AppEnvironment] enum value determining the environment
///   the app should run under (e.g., PROD, DEV).
Future<void> mainCommon(AppEnvironment environment) async {
  // Ensures that plugin services, like the widget binding, are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // Initializes environment information with the provided [environment].
  EnvInfo.initialize(environment);

  // Sets the system UI overlay style, particularly the status bar color and brightness.
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black, // Makes the status bar color black.
      statusBarBrightness:
          Brightness.light, // Sets the status bar brightness to light.
    ),
  );

  // Runs the app with a [ProviderScope] allowing Riverpod to override the behavior of providers.
  runApp(
    ProviderScope(
      observers: [
        Observers(), // Registers observers for Riverpod providers, if any.
      ],
      child: const GoogleExporter(), // The root widget of the application.
    ),
  );
}
