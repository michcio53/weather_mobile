import 'package:dio/dio.dart';
import 'package:domain/data_source/weather_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:remote/http_provider.dart';
import 'package:remote/weather/mapper/consolidated_weather_mapper.dart';
import 'package:remote/weather/mapper/location_mapper.dart';
import 'package:remote/weather/mapper/weather_for_place_mapper.dart';
import 'package:remote/weather/weather_data_source_impl.dart';

const isLoggingEnabled = kDebugMode;

/// GetIt extenstion, should be used on lower layers
extension RemoteInjector on GetIt {
  /// Registers all datasources
  void registerRemote({
    required String baseUrl,
  }) {
    this
      ..registerSingleton(Dio())
      ..registerFactory(() => HttpProvider(dio: get(), baseUrl: baseUrl))
      ..registerFactory(
        () => get<HttpProvider>().create(isLoggingEnabled: isLoggingEnabled),
      )
      ..registerFactory(
        () => const ConsolidatedWeatherMapper(),
      )
      ..registerFactory(
        () => WeatherForPlaceMapper(
          consolidatedWeatherMapper: get(),
        ),
      )
      ..registerFactory(
        () => const LocationMapper(),
      )
      ..registerFactory<WeatherDataSource>(
        () => WeatherDataSourceImpl(
          httpApiClient: get(),
          weatherForPlaceMapper: get(),
          locationMapper: get(),
        ),
      );
  }
}
