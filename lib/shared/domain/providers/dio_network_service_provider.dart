import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/shared/data/remote/dio_network_service.dart';

/// A provider for creating and providing a `DioNetworkService` instance.
///
/// This provider is responsible for creating a `Dio` client and then using it to
/// construct a `DioNetworkService`. The `DioNetworkService` class is assumed to be
/// a wrapper or service layer around the Dio client that handles network requests
/// for the application.
///
/// By using Riverpod's provider, `DioNetworkService` can be easily accessed and
/// reused across the application with proper dependency injection and state management.
final networkServiceProvider = Provider<DioNetworkService>(
  (ref) {
    // Create a new instance of the Dio client.
    final dio = Dio();
    // Instantiate the DioNetworkService with the Dio client.
    return DioNetworkService(dio);
  },
);
