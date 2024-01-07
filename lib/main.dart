import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/main/app.dart';
import 'package:google_exporter/main/app_env.dart';
import 'package:google_exporter/main/observers.dart';

void main() => mainCommon(AppEnvironment.PROD);

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  EnvInfo.initialize(environment);
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(
    ProviderScope(
      observers: [
        Observers(),
      ],
      child: const GoogleExporter(),
    ),
  );
}
