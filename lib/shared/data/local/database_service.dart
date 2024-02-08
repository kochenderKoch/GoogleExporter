import 'package:isar/isar.dart';
import 'package:objectbox/objectbox.dart';

/// An abstract class that serves as a base for all database services.
///
/// This class defines a basic interface for database operations,
/// which should be extended by specific implementations based on
/// different database engines (e.g., Isar).
abstract class DatabaseService {
  /// A Future instance of [Isar] or [Store] that waits for the initialization of the
  /// database.
  ///
  /// Each implementation of this class should initialize this Future instance
  /// to gain access to the database as soon as it is loaded and ready. This
  /// enables asynchronous access to the database.
  late dynamic db;
}
