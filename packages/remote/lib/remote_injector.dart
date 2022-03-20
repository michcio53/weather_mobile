import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:remote/http_provider.dart';

const isLoggingEnabled = kDebugMode;

/// GetIt extenstion, should be used on lower layers
extension RemoteInjector on GetIt {
  /// Registers all datasources
  void registerRemote({
    required String baseUrl,
  }) {
    this
      ..registerSingleton(http.Client())
      ..registerSingleton(
        HttpProvider(httpClient: get(), baseUrl: baseUrl),
      )
      ..registerLazySingleton(
        () => get<HttpProvider>().create(
          isLoggingEnabled: isLoggingEnabled,
        ),
      );
  }
}
