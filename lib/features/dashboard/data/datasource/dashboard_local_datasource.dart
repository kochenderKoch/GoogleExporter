import 'package:dartz/dartz.dart';
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';
import 'package:isar/isar.dart';

// ignore: one_member_abstracts
abstract class DashboardDatasource {
  Future<Either<AppException, List<Notice>>> fetchAllNotices();
  Future<Either<AppException, bool>> addNotice(Notice newNotice);
  Future<Either<AppException, bool>> deleteNotice(Notice existingNotice);
}

class DashboardLocalDatasource extends DashboardDatasource {
  DashboardLocalDatasource(this.databaseService);
  final DatabaseService databaseService;

  @override
  Future<Either<AppException, List<Notice>>> fetchAllNotices() async {
    final isar = await databaseService.db;
    final dataset = await isar.notices.where().findAll();
    return Right(dataset);
  }

  @override
  Future<Either<AppException, bool>> addNotice(Notice newNotice) async {
    final isar = await databaseService.db;
    await isar.writeTxn(() async {
      await isar.notices.put(newNotice); // Einfügen & akualisieren
    });
    return const Right(true);
  }

  @override
  Future<Either<AppException, bool>> deleteNotice(Notice existingNotice) async {
    final isar = await databaseService.db;
    await isar.writeTxn(() async {
      await isar.notices.delete(existingNotice.id); // Löschen
    });
    return const Right(true);
  }
}
