import 'package:dartz/dartz.dart';
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/projects/project_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

import 'package:objectbox/objectbox.dart';

abstract class ProjectDatasource {
  Future<Either<AppException, List<Project>>> fetchAllProjects();
  Future<Either<AppException, bool>> addProject(Project newProject);
  Future<Either<AppException, bool>> deleteProject(Project existingProject);
  Future<Either<AppException, bool>> updateProject(Project updatedProject);
  Future<Either<AppException, Project>> getProjectById(int id);
}

class ProjectLocalDatasource extends ProjectDatasource {
  ProjectLocalDatasource(this.databaseService);
  final DatabaseService databaseService;

  @override
  Future<Either<AppException, List<Project>>> fetchAllProjects() async {
    final store = await databaseService.db as Store;
    try {
      final dataset = await store.box<Project>().getAll();;
      return Right(dataset);
    } catch (e) {
      return Left(AppException(
          message: 'Failed to fetch all projects: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedFetchProjectsDatabase"));
    }
  }

  @override
  Future<Either<AppException, bool>> addProject(Project newProject) async {
    final store = await databaseService.db as Store;
    try {
      await store.box<Project>().put(newProject);
      return const Right(true);
    } catch (e) {
      return Left(AppException(
          message: 'Failed to add the project: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedAddProjectDatabase"));
    }
  }

  @override
  Future<Either<AppException, bool>> deleteProject(
      Project existingProject) async {
    final store = await databaseService.db as Store;
    try {
      await store.box<Project>().remove(existingProject.id);
      return const Right(true);
    } catch (e) {
      return Left(AppException(
          message: 'Failed to delete the project: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedDeleteProjectDatabase"));
    }
  }

  @override
  Future<Either<AppException, bool>> updateProject(
      Project updatedProject) async {
    final store = await databaseService.db as Store;
    try {
      await store.box<Project>().put(updatedProject);
      return const Right(true);
    } catch (e) {
      return Left(AppException(
          message: 'Failed to update the project: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedUpdateProjectDatabase"));
    }
  }

  @override
  Future<Either<AppException, Project>> getProjectById(int id) async {
    final store = await databaseService.db as Store;
    Project? project;
    try {
        project = await store.box<Project>().get(id);
      if (project == null) {
        return Left(
          AppException(
              message: 'Failed to get the project',
              statusCode: 101,
              identifier: "FailedGetProjectDatabase"),
        );
      } else {
        return Right(project);
      }
    } catch (e) {
      return Left(AppException(
          message: 'Failed to update the project: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedUpdateProjectDatabase"));
    }
  }
}
