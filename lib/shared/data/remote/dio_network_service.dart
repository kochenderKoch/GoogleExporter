import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_exporter/configs/app_configs.dart';
import 'package:google_exporter/shared/data/remote/interceptors/interceptors.dart';
import 'package:google_exporter/shared/data/remote/network_service.dart';
import 'package:google_exporter/shared/domain/models/response.dart' as response;
import 'package:google_exporter/shared/exceptions/http_exception.dart';
import 'package:google_exporter/shared/globals.dart';
import 'package:google_exporter/shared/mixins/exception_handler_mixin.dart';

class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  DioNetworkService(this.dio) {
    // this throws error while running test
    if (!kTestMode) {
      dio.options = dioBaseOptions;
      if (kDebugMode) {
        dio.interceptors.addAll({
          AuthInterceptors(dio),
          LoggingInterceptors(),
          // TalkerDioLogger(
          //   talker: talker,
          //   settings: const TalkerDioLoggerSettings(
          //     printRequestHeaders: Config.isDetailedLogging,
          //     printResponseHeaders: Config.isDetailedLogging,
          //     printRequestData: Config.isDetailedLogging,
          //     printResponseData: Config.isDetailedLogging,
          //   ),
          // ),
        });
      }
    }
  }
  final Dio dio;

  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        receiveTimeout: AppConfigs.receiveTimeout,
        connectTimeout: AppConfigs.connectionTimeout,
        sendTimeout: AppConfigs.sendTimeout,
      );
  @override
  String get baseUrl => AppConfigs.baseURL;

  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    if (!kTestMode) {
      dio.options.headers = header;
    }
    return header;
  }

  @override
  Future<Either<AppException, response.Response>> post(
    String endpoint, {
    Map<String, dynamic>? data,
  }) {
    final res = handleException(
      () => dio.post(
        endpoint,
        data: data,
      ),
      endpoint: endpoint,
    );
    return res;
  }

  @override
  Future<Either<AppException, response.Response>> get(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
  }) {
    final res = handleException(
      () => dio.get(
        endpoint,
        queryParameters: queryParameters,
      ),
      endpoint: endpoint,
    );
    return res;
  }
}
