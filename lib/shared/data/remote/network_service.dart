import 'package:dartz/dartz.dart';

import '../../domain/models/response.dart';
import '../../exceptions/http_exception.dart';

/// An abstract class representing the blueprint for a network service.
///
/// This class defines the required properties and methods for a network service
/// that will be responsible for making HTTP requests and handling responses.
/// Implementations of this class should provide concrete logic for these methods.
abstract class NetworkService {
  /// The base URL of the API that the network service will interact with.
  String get baseUrl;

  /// A map of headers that should be sent with each request.
  Map<String, Object> get headers;

  /// Updates the headers with additional data.
  ///
  /// This can be used to set or update authentication tokens or other necessary
  /// information before making a request.
  ///
  /// [data] is a map containing the new header values to be updated.
  void updateHeader(Map<String, dynamic> data);

  /// Performs a GET request to the given [endpoint].
  ///
  /// Optionally, [queryParameters] can be provided to include in the request.
  ///
  /// Returns an [Either] with [AppException] for failures or [Response] for success.
  ///
  /// [endpoint] is the URL path that will be appended to the base URL.
  /// [queryParameters] are the optional query parameters to be appended to the URL.
  Future<Either<AppException, Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  });

  /// Performs a POST request to the given [endpoint].
  ///
  /// Optionally, [data] can be provided as the body of the request.
  ///
  /// Returns an [Either] with [AppException] for failures or [Response] for success.
  ///
  /// [endpoint] is the URL path that will be appended to the base URL.
  /// [data] is the optional body data to be sent with the request.
  Future<Either<AppException, Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  });
}
