import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '/objectbox.g.dart';
import '../../data/local/database_service.dart';

class ObjectBoxDatabaseService extends DatabaseService {
  /// The Store of this app.

  ObjectBoxDatabaseService() {
    // Add any additional setup code, e.g. build queries.
    db = create();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<Store> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart

    final db =
        await openStore(directory: p.join(docsDir.path, "GoogleExporter"));
    return db;
  }

  void close() {
    db.close();
  }
}
