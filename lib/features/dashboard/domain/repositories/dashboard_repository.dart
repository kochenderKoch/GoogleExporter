import 'package:dartz/dartz.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

// ignore: one_member_abstracts
abstract class DashboardRepository {
  Future<Either<AppException, List<Notice>>> fetchNotices();
  Future<Either<AppException, bool>> addNotice(Notice newNotice);
  Future<Either<AppException, bool>> deleteNotice(Notice existingNotice);
  Future<Either<AppException, bool>> updateNotice(Notice updatedNotice);
}
