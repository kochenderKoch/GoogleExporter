import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_exporter/shared/data/remote/dio_network_service.dart';

final netwokServiceProvider = Provider<DioNetworkService>(
  (ref) {
    final dio = Dio();
    return DioNetworkService(dio);
  },
);
