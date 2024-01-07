import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:google_exporter/shared/data/remote/network_service.dart';
import 'package:google_exporter/shared/domain/models/response.dart' as response;
import 'package:google_exporter/shared/exceptions/http_exception.dart';

mixin ExceptionHandlerMixin on NetworkService {
  Future<Either<AppException, response.Response>>
      handleException<T extends Object>(
    Future<Response<dynamic>> Function() handler, {
    String endpoint = '',
  }) async {
    try {
      final res = await handler();
      return Right(
        response.Response(
          statusCode: res.statusCode ?? 200,
          data: res.data,
          statusMessage: res.statusMessage,
        ),
      );
    } catch (e) {
      var message = '';
      var identifier = '';
      var statusCode = 0;
      log(e.runtimeType.toString());
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
