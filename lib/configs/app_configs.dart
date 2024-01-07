/// All static [AppConfigs] settings for the Application
class AppConfigs {
  /// Base URL for HTTP Requests
  static const String baseURL = 'https://kontests.net/api';

  /// Time to wait for a HTTP Response
  static const Duration receiveTimeout = Duration(seconds: 15);

  /// Time to wait for a connection
  static const Duration connectionTimeout = Duration(seconds: 15);

  /// Time to wait for a request to finish
  static const Duration sendTimeout = Duration(seconds: 15);
}
