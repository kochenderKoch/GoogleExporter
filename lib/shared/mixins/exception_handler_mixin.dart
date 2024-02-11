import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../data/remote/network_service.dart';
import '../domain/models/response.dart' as response;
import '../exceptions/http_exception.dart';

/// Mixin that provides exception handling capabilities to the [NetworkService].
mixin ExceptionHandlerMixin on NetworkService {
  /// Handles exceptions for network calls and returns either an [AppException] or a successful response.
  ///
  /// - [handler]: A function that performs the network request and may throw exceptions.
  /// - [endpoint]: Optional parameter representing the endpoint being called, used for logging.
  ///
  /// Returns an [Either] type that is [Left] with an [AppException] on failure or
  /// [Right] with a [response.Response] on success.
  Future<Either<AppException, response.Response>>
      handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    try {
      // Execute the provided handler function and await the response.
      final res = await handler();
      // Wrap and return the successful response in a Right.
      return Right(
        response.Response(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          statusMessage: res.statusMessage,
        ),
      );
    } catch (e) {
      // Initialize default error values.
      var message = '';
      var identifier = '';
      var statusCode = 0;

      // Log the exception type.
      log(e.runtimeType.toString());

      // Switch on the type of exception caught to handle different error scenarios.
      switch (e.runtimeType) {
        case SocketException:
          e as SocketException;
          message = 'Unable to connect to the server.';
          statusCode = 0;
          identifier = 'Socket Exception ${e.message}\n at  $endpoint';

        case DioException:
          e as DioException;
          // ignore: avoid_dynamic_calls
          message = e.response?.data?['message'].toString() ??
              'Internal Error occured';
          statusCode = 1;
          identifier = 'DioException ${e.message} \nat  $endpoint';

        default:
          message = 'Unknown error occured';
          statusCode = 2;
          identifier = 'Unknown error $e\n at $endpoint';
      }

      // Wrap and return the error information in a Left.
      return Left(
        AppException(
          message: message,
          statusCode: statusCode,
          identifier: identifier,
        ),
      );
    }
  }
}
