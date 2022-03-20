import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:remote/http_api_client.dart';

/// Wraps httpClient into chopper client
class HttpProvider {
  const HttpProvider({
    required http.Client httpClient,
    required String baseUrl,
  })  : _httpClient = httpClient,
        _baseUrl = baseUrl;

  final http.Client _httpClient;
  final String _baseUrl;
  
  HttpApiClient create({
    required bool isLoggingEnabled,
  }) {
    final chopperClient = ChopperClient(
      baseUrl: _baseUrl,
      client: _httpClient,
    );

    return HttpApiClient.create(client: chopperClient);
  }
}
