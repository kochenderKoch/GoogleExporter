import '../main.dart';
import './app_env.dart';

/// Entry point of the application for the staging environment.
/// Calls [mainCommon] with [AppEnvironment.STAGING] as an argument.
Future<void> main() async => mainCommon(AppEnvironment.STAGING);
