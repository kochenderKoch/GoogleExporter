import '/main.dart';
import '../main/app_env.dart';

/// Entry point of the application for the development environment.
/// Calls [mainCommon] with [AppEnvironment.DEV] as an argument.
Future<void> main() async => mainCommon(AppEnvironment.DEV);
