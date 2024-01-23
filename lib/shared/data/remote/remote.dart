// Exporting `DioNetworkService` to make it available for use throughout the application.
// This class provides a concrete implementation of `NetworkService` using the Dio package,
// including setup for request headers, interceptors, and exception handling.
export 'dio_network_service.dart';

// Exporting the abstract class `NetworkService`.
// This serves as a contract for network operations in the application, defining methods
// for performing HTTP GET and POST requests and for updating request headers.
// Implementations of this class must fulfill these method contracts.
export 'network_service.dart';
