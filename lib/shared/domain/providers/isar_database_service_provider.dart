import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/shared/data/local/isar_database_service.dart';

/// A provider for creating and providing an `IsarDatabaseService` instance.
///
/// This provider is responsible for creating an instance of `IsarDatabaseService`.
/// The `IsarDatabaseService` is a class that likely encapsulates all the operations
/// related to the Isar database, such as opening a connection, performing CRUD operations,
/// and closing the connection.
///
/// By using a Riverpod provider, the `IsarDatabaseService` can be easily managed and accessed
/// throughout the application, ensuring that database operations are centralized and consistent.
final databaseServiceProvider = Provider<IsarDatabaseService>(
  (ref) {
    // Instantiate the IsarDatabaseService.
    return IsarDatabaseService();
  },
);

final databaseProjectServiceProvider =
    Provider.family<IsarDatabaseService, String>(
  (ref, path) {
    // Instantiate the IsarDatabaseService.
    return IsarDatabaseService.project(path);
  },
);
