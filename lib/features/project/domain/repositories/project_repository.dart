import 'package:dartz/dartz.dart';
import 'package:google_exporter/shared/domain/models/projects/project_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

abstract class ProjectRepository {
  Future<Either<AppException, List<Project>>> fetchProjects();
  Future<Either<AppException, bool>> addProject(Project newNotice);
  Future<Either<AppException, bool>> deleteProject(Project existingNotice);
  Future<Either<AppException, bool>> updateProject(Project updatedNotice);
}
