import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';
import 'package:google_exporter/shared/domain/models/settings/settings_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// Ein Service zur Verwaltung von CRUD-Operationen für eine Isar-Datenbank.
///
/// Diese Klasse erweitert [DatabaseService] und implementiert Methoden
/// zum Öffnen und Verwalten einer Isar-Datenbankinstanz.
class IsarDatabaseService extends DatabaseService {
  /// Konstruktor der [IsarDatabaseService]-Klasse.
  ///
  /// Ruft [openGeneralDB] auf, um eine neue Isar-Datenbankinstanz zu öffnen
  /// und speichert diese in der vererbten [db] Future-Variable.
  IsarDatabaseService() {
    db = openGeneralDB();
  }

  /// Öffnet eine Isar-Datenbank aus dem Anwendungsverzeichnis.
  ///
  /// Startet den Isar-Inspektor nur im Debug-Modus, um die Datenbankinhalte
  /// während der Entwicklung zu überwachen. Im Produktionsmodus ist der
  /// Inspektor deaktiviert, um die Leistung zu verbessern.
  ///
  /// Returns:
  /// Ein Future, die ein Isar-DB-Instance zurückgibt, sobald diese bereit ist.
  Future<Isar> openGeneralDB() async {
    // Überprüft, ob die App im Web ausgeführt wird.
    if (!kIsWeb) {
      // Holt das Anwendungsverzeichnis für nicht-Web-Plattformen.
      final dir = await getApplicationDocumentsDirectory();
      // Öffnet eine Isar-Datenbank im Anwendungsverzeichnis und gibt die Instanz zurück.
      return Isar.open(
        [NoticeSchema, SettingsSchema],
        directory: dir.path,
      );
    } else {
      // Öffnet eine Isar-Datenbank im festgelegten Verzeichnis '/home' für Web-Plattformen.
      return Isar.open(
        [NoticeSchema, SettingsSchema],
        directory: '/home',
      );
    }
  }

  // TODO(kochenderKoch): Implementieren Sie eine Methode zum Öffnen einer projektspezifischen Datenbank.
  // Beispiel: Future<Isar> openProjectDB(Directory dir) async {...}
}
