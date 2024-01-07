import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/shared/data/local/isar_database_service.dart';

final databaseServiceProvider = Provider<IsarDatabaseService>(
  (ref) {
    return IsarDatabaseService();
  },
);
