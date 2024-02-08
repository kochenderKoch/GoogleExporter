import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/shared/data/local/objectbox_database_service.dart';

final generalDatabaseServiceProvider = Provider<ObjectBoxDatabaseService>(
  (ref) {
    // Instantiate the IsarDatabaseService.
    return ObjectBoxDatabaseService();
  },
);
