import 'package:domain/store/weather_store.dart';
import 'package:domain/usecase/save_location_id_use_case.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class MockWeatherStore extends Mock implements WeatherStore {}

void main() {
  late SaveLocationIdUseCase saveLocationIdUseCase;
  late MockWeatherStore mockWeatherStore;

  setUp(() {
    mockWeatherStore = MockWeatherStore();

    saveLocationIdUseCase = SaveLocationIdUseCase(weatherStore: mockWeatherStore);
  });

  test('Given correct parameters it invokes every method in usecase and returns unit value', () async {
    when(() => mockWeatherStore.setWoeid(any())).thenAnswer((_) => Future.value(true));

    final result = await saveLocationIdUseCase.execute(param: 123).run();

    verify(() => mockWeatherStore.setWoeid(any())).called(1);

    result.fold((l) => throw Exception(l.toString()), (r) => expect(r, unit));
  });

  test(
      'Given false value to SaveLocationIdUseCase it invokes every method in usecase and returns SaveLocationIdFailure.unexpected',
      () async {
    when(() => mockWeatherStore.setWoeid(any())).thenAnswer((_) => Future.value(false));

    final result = await saveLocationIdUseCase.execute(param: 123).run();

    verify(() => mockWeatherStore.setWoeid(any())).called(1);

    result.fold(
      (exceptionDetail) => expect(exceptionDetail, SaveLocationIdFailure.unexpected),
      (r) {},
    );
  });
}
