import 'package:dartz/dartz.dart';
import 'package:google_exporter/shared/data/local/database_service.dart';
import 'package:google_exporter/shared/domain/models/projects/project_model.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';
import 'package:isar/isar.dart';

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
    final isar = await databaseService.db as Isar;
    try {
      final dataset = await isar.projects.where().findAll();
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
    final isar = await databaseService.db;
    try {
      await isar.writeTxn(() async {
        await isar.projects.put(newProject);
      });
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
    final isar = await databaseService.db;
    try {
      await isar.writeTxn(() async {
        await isar.notices.delete(existingProject.id!);
      });
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
    final isar = await databaseService.db;
    try {
      await isar.writeTxn(() async {
        await isar.projects.put(updatedProject);
      });
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
    final isar = await databaseService.db as Isar;
    Project? project;
    try {
      await isar.writeTxn(() async {
        project = await isar.projects.get(id);
      });
      if (project == null) {
        return Left(
          AppException(
              message: 'Failed to get the project',
              statusCode: 101,
              identifier: "FailedGetProjectDatabase"),
        );
      } else {
        return Right(project!);
      }
    } catch (e) {
      return Left(AppException(
          message: 'Failed to update the project: ${e.toString()}',
          statusCode: 101,
          identifier: "FailedUpdateProjectDatabase"));
    }
  }
}
