import 'package:isar/isar.dart';

abstract class DatabaseService {
  late Future<Isar> db;

  // Future<Either<AppException, String>> add();

  // Future<Either<AppException, String>> delete();
}
