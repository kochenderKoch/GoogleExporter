import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// A custom [Interceptor] for the Dio HTTP client that logs requests, responses,
/// and errors to the standard output (stdout), typically the console.
///
/// This interceptor can be added to the Dio instance to help with debugging by
/// printing network call details as they occur.
class LoggingInterceptors extends Interceptor {
  /// Intercepts the request before it is sent and logs its details.
  ///
  /// [options] contains the request's configurations such as method, path, headers, etc.
  /// [handler] is used to continue or reject the request processing.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Print request method and path to the console.
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    // Continue with the request processing.
    return super.onRequest(options, handler);
  }

  /// Intercepts the response from the server and logs its details.
  ///
  /// [response] contains the response data and configurations.
  /// [handler] is used to continue or reject the response processing.
  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    // Print response status code and path to the console.
    debugPrint(
      'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
    );
    // Continue with the response processing.
    return super.onResponse(response, handler);
  }

  /// Intercepts errors that occur during request or response handling and logs them.
  ///
  /// [err] contains the error information and request configurations.
  /// [handler] is used to continue or reject the error handling process.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Print error status code (if available) and path to the console.
    debugPrint(
      'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    );
    // Continue with the error handling process.
    return super.onError(err, handler);
  }
}
