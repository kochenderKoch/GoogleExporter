import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// A service for managing CRUD operations for an Isar database.
///
/// This class extends [DatabaseService] and implements methods
/// for opening and handling an Isar database instance.
class IsarDatabaseService extends DatabaseService {
  /// Constructor for the [IsarDatabaseService] class.
  ///
  /// Calls [openGeneralDB] to open a new Isar database instance
  /// and stores it in the inherited [db] Future variable.
  IsarDatabaseService() {
    db = openGeneralDB();
  }

  /// Opens an Isar database from the application directory.
  ///
  /// Starts the Isar inspector only in debug mode to monitor the database contents
  /// during development. In production mode, the inspector is disabled to improve performance.
  ///
  /// Returns:
  /// A Future that returns an Isar DB instance once it's ready.
  Future<Isar> openGeneralDB() async {
    // Checks if the app is running on the web.
    if (!kIsWeb) {
      // Retrieves the application directory for non-web platforms.
      final dir = await getApplicationDocumentsDirectory();
      // Opens an Isar database in the application directory and returns the instance.
      return Isar.open(
        [NoticeSchema, SettingsSchema],
        directory: dir.path,
      );
    } else {
      // Opens an Isar database in the specified directory '/home' for web platforms.
      return Isar.open(
        [NoticeSchema, SettingsSchema],
        directory: '/home',
      );
    }
  }

  // TODO(kochenderKoch): Implement a method for opening a project-specific database.
  // Example: Future<Isar> openProjectDB(Directory dir) async {...}
}
