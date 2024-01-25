import 'package:dartz/dartz.dart';
import 'package:google_exporter/features/project/data/datasource/project_local_datasource.dart';
import 'package:google_exporter/features/project/domain/repositories/project_repository.dart';
import 'package:google_exporter/shared/domain/models/projects/project_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  ProjectRepositoryImpl(this.projectDatasource);
  final ProjectDatasource projectDatasource;

  @override
  Future<Either<AppException, bool>> addProject(Project newProject) {
    return projectDatasource.addProject(newProject);
  }

  @override
  Future<Either<AppException, bool>> deleteProject(Project existinexistingProject) {
    return projectDatasource.deleteProject(existinexistingProject);
  }

  @override
  Future<Either<AppException, List<Project>>> fetchProjects() {
    return projectDatasource.fetchAllProjects();
  }

  @override
  Future<Either<AppException, bool>> updateProject(Project updatedProject) {
    return projectDatasource.updateProject(updatedProject);
  }
}
