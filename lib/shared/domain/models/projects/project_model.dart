import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:isar/isar.dart';

part 'project_model.g.dart';

/// [Project] definiert das Schema für die Projektentitäten
/// in der Isar-Datenbank.
///
/// Jedes Projekt wird durch einen eindeutigen Namen, eine Beschreibung und eine
/// optionale ID, die von Isar verwaltet wird, identifiziert.
@collection
@JsonSerializable()
class Project {
  /// Konstruktor für die [Project]-Klasse.
  ///
  /// [name] und [description] sind erforderlich und müssen bei der Erzeugung
  /// eines neuen [Project]-Objekts angegeben werden. Die [id] wird von der
  /// Isar-Datenbank automatisch zugewiesen, sobald das [Project]-Objekt
  /// eingefügt wird, daher ist sie optional im Konstruktor.
  Project(
      {required this.name,
      required this.identifier,
      required this.processor,
      required this.path,
      this.description,
      this.id});

  /// Eindeutige Identifikationsnummer des Projekts in der Isar-Datenbank.
  ///
  /// Diese ID wird automatisch von Isar zugewiesen, wenn ein neues Projekt
  /// erstellt wird. Daher kann sie null sein, bevor das Objekt in der
  /// Datenbank gespeichert wurde.

  Id? id = Isar.autoIncrement;

  /// Der eindeutige Name des Projekts.
  ///
  /// Ein Index wird auf dieses Feld gesetzt, um schnelle Abfragen zu
  /// ermöglichen. Optional könnte hier `unique: true` hinzugefügt werden,
  /// um die Einzigartigkeit des Projekt-Namens zu erzwingen.
  @Index()
  String name;

  /// Eine kurze Beschreibung des Projekts.
  @Index()
  String? description;

  // Hier könnten weitere Felder und Methoden hinzugefügt werden, die für
  // das Projekt relevant sind, zum Beispiel Deadlines, Status, Mitglieder etc.
  @Index()
  String identifier;

  @Index()
  String processor;

  @Index(unique: true)
  String path;
}
