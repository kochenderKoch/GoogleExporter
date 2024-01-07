import 'package:dartz/dartz.dart';
import 'package:google_exporter/shared/exceptions/http_exception.dart';

class Response {
  Response({
    required this.statusCode,
    this.statusMessage,
    this.data = const <dynamic, dynamic>{},
  });
  final int statusCode;
  final String? statusMessage;
  final dynamic data;
  @override
  String toString() {
    return 'statusCode=$statusCode\nstatusMessage=$statusMessage\n data=$data';
  }
}

extension ResponseExtension on Response {
  Right<AppException, Response> get toRight => Right(this);
}
