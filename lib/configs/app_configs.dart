import '../shared/executor/executor.dart';

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

  /// The maximum number of concurrent operations in an executor queue allowed.
  static const int CONCURRENCY = 5;

  /// The rate at which the operations are performed in an executor queue.
  static final Rate RATE = Rate.perSecond(10);

  /// The delay between each operation due to API limitations.
  static const Duration DELAY = Duration(milliseconds: 500);

  static const int DEFAULT_PADDING = 6;
}
