import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:google_exporter/shared/domain/models/response.dart';

/// Represents a custom application exception with additional error information.
class AppException implements Exception {
  /// Constructs an [AppException] with a message, status code, and identifier.
  ///
  /// - [message]: A nullable string containing the error message.
  /// - [statusCode]: A nullable integer representing the HTTP status code.
  /// - [identifier]: A nullable string uniquely identifying the type of exception.
  AppException({
    required this.message,
    required this.statusCode,
    required this.identifier,
  });

  final String? message;
  final int? statusCode;
  final String? identifier;

  /// Returns a string representation of [AppException].
  @override
  String toString() {
    return 'statusCode=$statusCode\nmessage=$message\nidentifier=$identifier';
  }
}

/// Represents an exception for cache-related failures.
///
/// Inherits from [Equatable] to facilitate value comparison.
class CacheFailureException extends Equatable implements AppException {
  /// Unique identifier for a cache failure exception.
  @override
  String? get identifier => 'Cache failure exception';

  /// Message indicating an issue with saving user data to the cache.
  @override
  String? get message => 'Unable to save user';

  /// Status code associated with cache failure.
  @override
  int? get statusCode => 100;

  /// List of properties used to determine whether two instances are equal.
  @override
  List<Object?> get props => [message, statusCode, identifier];
}

/// Extension on [AppException] to provide a convenient method to return
/// an instance of [AppException] as a [Left] type in a [Either] context.
extension HttpExceptionExtension on AppException {
  /// Converts [AppException] to a [Left] type containing the exception.
  Left<AppException, Response> get toLeft => Left<AppException, Response>(this);
}
