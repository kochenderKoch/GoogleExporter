import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

/// The [Dio]-Requests and [Dio]-Response gets interrupted to log the output to
/// stdout.
class LoggingInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    debugPrint(
      '''RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}''',
    );
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
      '''ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}''',
    );
    return super.onError(err, handler);
  }
}
