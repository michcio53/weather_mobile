import 'package:dio/dio.dart';
import 'package:remote/http_api_client.dart';

/// Wraps dio into separate class
class HttpProvider {
  const HttpProvider({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String _baseUrl;

  HttpApiClient create({
    required bool isLoggingEnabled,
  }) {
    _dio.options.baseUrl = _baseUrl;

    return HttpApiClient(_dio);
  }
}
