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

/// DioNetworkService is a network layer class that wraps the Dio package
/// to provide simplified methods for HTTP requests. It extends the
/// NetworkService class and uses ExceptionHandlerMixin to uniformly handle exceptions.
///
/// The service initializes with a Dio object and sets up interceptors for
/// authentication, logging, and other purposes as necessary. It overrides the
/// NetworkService's methods to include this additional functionality.
class DioNetworkService extends NetworkService with ExceptionHandlerMixin {
  /// The constructor takes a Dio object, which will be used for all HTTP operations.
  /// It sets up Dio with base options and adds interceptors for logging and authentication
  /// when not in test mode and if the app is in debug mode.
  ///
  /// Throws: If an error occurs during interceptor setup or option configuration.
  DioNetworkService(this.dio) {
    // Set Dio options and interceptors, unless running in test mode.
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

  /// The base configuration for Dio requests, including the default headers,
  /// the base URL, and various timeouts.
  BaseOptions get dioBaseOptions => BaseOptions(
        baseUrl: baseUrl,
        headers: headers,
        receiveTimeout: AppConfigs.receiveTimeout,
        connectTimeout: AppConfigs.connectionTimeout,
        sendTimeout: AppConfigs.sendTimeout,
      );

  /// The base URL for all HTTP requests.
  @override
  String get baseUrl => AppConfigs.baseURL;

  /// Default HTTP headers to be included with every request.
  @override
  Map<String, Object> get headers => {
        'accept': 'application/json',
        'content-type': 'application/json',
      };

  /// Updates the Dio instance's default headers with additional headers provided
  /// in the [data] parameter. This can be used to set authentication tokens or
  /// other per-request headers.
  ///
  /// Returns the updated headers.
  @override
  Map<String, dynamic>? updateHeader(Map<String, dynamic> data) {
    final header = {...data, ...headers};
    if (!kTestMode) {
      dio.options.headers = header;
    }
    return header;
  }

  /// Sends a POST request to the specified [endpoint] with optional [data].
  /// This method handles exceptions using the ExceptionHandlerMixin.
  ///
  /// Returns an Either type representing a successful response or an error.
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

  /// Sends a GET request to the specified [endpoint] with optional [queryParameters].
  /// This method handles exceptions using the ExceptionHandlerMixin.
  ///
  /// Returns an Either type representing a successful response or an error.
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
