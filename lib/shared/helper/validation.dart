import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

Either<AppException, String> validateAndCompletePath(String pathStr,
    [String defaultFilename = 'default.db']) {
  // Regular Expression, um einfache ungültige Pfadzeichen zu überprüfen
  RegExp invalidCharsRegExp = RegExp(r'[<>"|?*]');

  // Überprüfen auf ungültige Zeichen in allen Betriebssystemen
  if (invalidCharsRegExp.hasMatch(pathStr)) {
    return Left(
      AppException(
          message: 'Ungültiger Pfad',
          statusCode: 102,
          identifier: "InvalidPath"),
    );
  }

  // Überprüfen, ob es sich um ein Verzeichnis handelt (endet mit einem Slash oder Backslash)
  if (pathStr.endsWith('/') || pathStr.endsWith('\\')) {
    // Ein Verzeichnis wurde angegeben, fügen Sie den Standarddateinamen hinzu
    return Right(pathStr + defaultFilename);
  }

  // Überprüfen, ob eine Dateierweiterung vorhanden ist
  if (pathStr.contains('.')) {
    // Der Pfad scheint bereits eine Datei zu sein
    return Right(pathStr);
  } else {
    // Keine Dateierweiterung gefunden, also fügen Sie den Standarddateinamen hinzu
    return Right(pathStr + '/' + defaultFilename);
  }
}

Either<AppException, void> checkPath(String pathStr) {
  final entity = FileSystemEntity.typeSync(pathStr);

  switch (entity) {
    case FileSystemEntityType.directory:
      debugPrint('Der Pfad ist ein Verzeichnis.');
      return Right(null);
    case FileSystemEntityType.file:
      debugPrint('Der Pfad ist eine Datei.');
      return Right(null);

    case FileSystemEntityType.notFound:
      debugPrint('Der Pfad existiert nicht.');
      return Left(AppException(
        message: 'Pfad existiert nicht',
        statusCode: 104,
        identifier: 'PathNotFound',
      ));
    default:
      debugPrint('Der Pfad ist weder eine Datei noch ein Verzeichnis.');
      return Left(
        AppException(
          message: 'Pfad ist kein Verzeichnis',
          statusCode: 105,
          identifier: 'PathIsNeitherFileNorDirectory',
        ),
      );
  }
}
