/// All static [AppConfigs] settings for the Application
class AppConfigs {
  /// Base URL for HTTP Requests
  /// Placeholder for now
  static const String baseURL = 'https://github.com/kochenderKoch';

  /// Time to wait for a HTTP Response
  static const Duration receiveTimeout = Duration(seconds: 15);

  /// Time to wait for a connection
  static const Duration connectionTimeout = Duration(seconds: 15);

  /// Time to wait for a request to finish
  static const Duration sendTimeout = Duration(seconds: 15);
}
