import 'package:dartz/dartz.dart';

import '/features/project/data/datasource/project_local_datasource.dart';
import '/features/project/domain/repositories/project_repository.dart';
import '/shared/domain/models/projects/project_model.dart';
import '/shared/exceptions/http_exception.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  ProjectRepositoryImpl(this.projectDatasource);
  final ProjectDatasource projectDatasource;

  @override
  Future<Either<AppException, bool>> addProject(Project newProject) {
    return projectDatasource.addProject(newProject);
  }

  @override
  Future<Either<AppException, bool>> deleteProject(
      Project existinexistingProject) {
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

  @override
  Future<Either<AppException, Project>> getProjectById(int id) {
    return projectDatasource.getProjectById(id);
  }
}
