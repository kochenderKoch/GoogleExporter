import 'package:dartz/dartz.dart';
import 'package:google_exporter/features/dashboard/data/datasource/dashboard_local_datasource.dart';
import 'package:google_exporter/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:google_exporter/shared/domain/models/notice/notice_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

class DashboardRepositoryImpl extends DashboardRepository {
  DashboardRepositoryImpl(this.dashboardDatasource);
  final DashboardDatasource dashboardDatasource;

  @override
  Future<Either<AppException, List<Notice>>> fetchNotices() {
    return dashboardDatasource.fetchAllNotices();
  }

  @override
  Future<Either<AppException, bool>> addNotice(Notice newNotice) {
    return dashboardDatasource.addNotice(newNotice);
  }

  @override
  Future<Either<AppException, bool>> deleteNotice(Notice existingNotice) {
    return dashboardDatasource.deleteNotice(existingNotice);
  }

  @override
  Future<Either<AppException, bool>> updateNotice(Notice updatedNotice) {
    return dashboardDatasource.updateNotice(updatedNotice);
  }
}
