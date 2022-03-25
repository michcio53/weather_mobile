import 'package:dio/dio.dart';
import 'package:mocktail/mocktail.dart';
import 'package:remote/http_provider.dart';
import 'package:test/test.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
  });

  test('Adding logging interceptor when isLoggingEnabled is true', () async {
    when(() => mockDio.options).thenReturn(BaseOptions());
    when(() => mockDio.interceptors).thenReturn(Interceptors());

    HttpProvider(baseUrl: '', dio: mockDio).create(isLoggingEnabled: true);

    verify(() => mockDio.interceptors.add(any())).called(1);
    verify(() => mockDio.options.baseUrl).called(1);
  });

  test('Do not add interceptor when isLoggingEnabled is false', () async {
    when(() => mockDio.options).thenReturn(BaseOptions());
    when(() => mockDio.interceptors).thenReturn(Interceptors());

    HttpProvider(baseUrl: '', dio: mockDio).create(isLoggingEnabled: false);

    verifyNever(() => mockDio.interceptors.add(any()));
    verify(() => mockDio.options.baseUrl).called(1);
  });
}
