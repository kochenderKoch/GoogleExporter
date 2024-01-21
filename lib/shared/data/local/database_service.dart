import 'package:isar/isar.dart';

/// Eine abstrakte Klasse, die als Basis für alle Datenbankservices dient.
///
/// Diese Klasse definiert ein grundlegendes Interface für Datenbankoperationen,
/// das von spezifischen Implementierungen erweitert werden sollte, die auf
/// unterschiedlichen Datenbank-Engines basieren (z.B. Isar).
abstract class DatabaseService {
  /// Eine Future-Instanz von [Isar], die auf die Initialisierung der
  /// Datenbank wartet.
  ///
  /// Jede Implementierung dieser Klasse sollte diese Future-Instanz
  /// initialisieren, um Zugriff auf die Datenbank zu ermöglichen, sobald
  /// sie geladen und bereit ist. Dies ermöglicht asynchronen Zugriff auf die
  /// Datenbank.
  late Future<Isar> db;
}
