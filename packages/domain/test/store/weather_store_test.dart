import 'package:domain/preference_assistant/preference_assistant.dart';
import 'package:domain/store/weather_store.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';

class MockPreferenceAssistant extends Mock implements PreferenceAssistant {}

void main() {
  late MockPreferenceAssistant mockPreferenceAssistant;
  late WeatherStore weatherStore;

  setUp(() {
    mockPreferenceAssistant = MockPreferenceAssistant();
    weatherStore = WeatherStore(preferenceAssistant: mockPreferenceAssistant);

    weatherStore = WeatherStore(
      preferenceAssistant: mockPreferenceAssistant,
    );
  });

  test('Given correct parameters it invokes prefeneces assistant method',
      () async {
    when(
      () => mockPreferenceAssistant.write(
        key: any(named: 'key'),
        value: any(
          named: 'value',
        ),
      ),
    ).thenAnswer(
      (_) => Future.value(true),
    );

    await weatherStore.setWoeid(123);

    verify(
      () => mockPreferenceAssistant.write(
        key: any(named: 'key'),
        value: any(named: 'value'),
      ),
    ).called(1);
  });

  test('Given correct parameters it invokes prefeneces assistant method',
      () async {
    when(() => mockPreferenceAssistant.read(key: any(named: 'key'))).thenReturn(
      123,
    );

    weatherStore.getWoeid();

    verify(
      () => mockPreferenceAssistant.read(
        key: any(named: 'key'),
      ),
    ).called(1);
  });
}
