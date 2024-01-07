import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_model.dart';

/// A class to manage CRUD-Transactions on an given [Isar]-Database
class IsarDatabaseService extends DatabaseService {
  /// Creates an [IsarDatabaseService] Instance and
  /// opens the [Isar]-Database for Transactions
  IsarDatabaseService() {
    db = openDB();
  }

  /// The [Isar] Database Instance

  /// Opens the given [Isar]-Databse from the Applications-Directory
  /// The Inspector is started only in debug mode.
  Future<Isar> openDB() async {
    if (!kIsWeb) {
      final dir = await getApplicationDocumentsDirectory();
      return Isar.open(
        [NoticeSchema, SettingsSchema],
        directory: dir.path,
      );
    } else {
      return Isar.open(
        [NoticeSchema, SettingsSchema],
        directory: '/home',
      );
    }
  }

  // @override
  // Future<Either<AppException, String>> add() {
  //   throw UnimplementedError();
  // }

  // @override
  // Future<Either<AppException, String>> delete() {
  //   throw UnimplementedError();
  // }

  /// Adds a [Text] to the matching table in the [db]
  // Future<void> addText(Text text) async {
  //   final isar = await db;
  //   isar.write((isar2) {
  //     isar2.texts.put(text); // insert & update
  //   });
  // }

  /// Remove a [Text] from the matching table in the [db]
  // Future<void> removeText(Text mail) async {
  //   final isar = await db;
  //   final existingEmail = isar.texts.get(mail.id);
  //   isar.write((isar2) {
  //     isar2.texts.delete(existingEmail!.id); // delete
  //   });
  // }

  /// Gets all [Text]-Objects as a [List] from the matching table in the [db]
  // Future<List<Text>> getTexts() async {
  //   final isar = await db;
  //   return isar.texts.where().findAll();
  // }
}
