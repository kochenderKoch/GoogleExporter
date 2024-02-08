import 'package:dartz/dartz.dart';
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';
import 'package:isar/isar.dart';

abstract class DashboardDatasource {
  Future<Either<AppException, List<Notice>>> fetchAllNotices();
  Future<Either<AppException, bool>> addNotice(Notice newNotice);
  Future<Either<AppException, bool>> deleteNotice(Notice existingNotice);
  Future<Either<AppException, bool>> updateNotice(Notice updatedNotice);
}

class DashboardLocalDatasource extends DashboardDatasource {
  DashboardLocalDatasource(this.databaseService);
  final DatabaseService databaseService;

  @override
  Future<Either<AppException, List<Notice>>> fetchAllNotices() async {
    final isar = await databaseService.db as Isar;
    try {
      final dataset = await isar.notices.where().findAll();
      return Right(dataset);
    } catch (e) {
      return Left(AppException(
          message: 'Failed to fetch all notices: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedFetchNoticesDatabase"));
    }
  }

  @override
  Future<Either<AppException, bool>> addNotice(Notice newNotice) async {
    final isar = await databaseService.db;
    try {
      await isar.writeTxn(() async {
        await isar.notices.put(newNotice);
      });
      return const Right(true);
    } catch (e) {
      return Left(AppException(
          message: 'Failed to add the notice: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedAddNoticeDatabase"));
    }
  }

  @override
  Future<Either<AppException, bool>> deleteNotice(Notice existingNotice) async {
    final isar = await databaseService.db;
    try {
      await isar.writeTxn(() async {
        await isar.notices.delete(existingNotice.id);
      });
      return const Right(true);
    } catch (e) {
      return Left(AppException(
          message: 'Failed to delete the notice: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedDeleteNoticeDatabase"));
    }
  }

  @override
  Future<Either<AppException, bool>> updateNotice(Notice updatedNotice) async {
    final isar = await databaseService.db;
    try {
      await isar.writeTxn(() async {
        await isar.notices.put(updatedNotice);
      });
      return const Right(true);
    } catch (e) {
      return Left(AppException(
          message: 'Failed to update the notice: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedUpdateNoticeDatabase"));
    }
  }
}
