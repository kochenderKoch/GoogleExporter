import 'package:dio/dio.dart';

/// `AuthInterceptors` is a custom interceptor for Dio that adds an authorization token
/// to each outgoing request. This class is meant to be used with the Dio HTTP client
/// to ensure that all requests are authenticated.
///
/// The interceptor also checks if the token is close to expiration, and if so,
/// it attempts to refresh the token before proceeding with the request.
class AuthInterceptors extends Interceptor {
  /// Constructor for `AuthInterceptors`.
  /// Accepts a [Dio] instance which will be used internally.
  AuthInterceptors(this.dio);

  /// The Dio client instance to which this interceptor will be added.
  /// It is used to lock and unlock the request when refreshing tokens.
  final Dio dio;

  /// Intercepts the request to possibly add an authorization token.
  ///
  /// [options] contains the request's configurations such as method, path, headers, etc.
  /// [handler] is used to continue or reject the request processing.
  ///
  /// This method would typically:
  /// 1. Retrieve the access token from a repository (e.g., `TokenRepository`).
  /// 2. Check if the token is about to expire.
  /// 3. If the token is near expiration, lock the request, refresh the token, unlock
  ///    the request, then proceed.
  /// 4. Add the 'Authorization' header with the bearer token to the request.
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // The logic for token retrieval, expiration check, and refresh has been commented out.
    // To enable this functionality, uncomment the code and implement the necessary repository
    // and service calls to manage the access token.

    // var accessToken = await TokenRepository().getAccessToken();

    // if (accessToken != null) {
    //   var expiration = await TokenRepository().getAccessTokenRemainingTime();

    //   if (expiration.inSeconds < 60) {
    //     dio.interceptors.requestLock.lock();

    //     // Call the refresh endpoint to get a new token
    //     await UserService().refresh().then((response) async {
    //       await TokenRepository().persistAccessToken(response.accessToken);
    //       accessToken = response.accessToken;
    //     }).catchError((error, stackTrace) {
    //       handler.reject(error, true);
    //     }).whenComplete(() => dio.interceptors.requestLock.unlock());
    //   }

    //   options.headers['Authorization'] = 'Bearer $accessToken';
    // }

    // Proceed with the request using the potentially updated options.
    return handler.next(options);
  }

  // Helper methods like `isTokenNearExpiration` and `refreshToken` would be implemented here.
  // TODO(kochenderKoch): Add helper methods
}
