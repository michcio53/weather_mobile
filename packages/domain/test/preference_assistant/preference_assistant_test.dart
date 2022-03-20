import 'package:domain/preference_assistant/preference_assistant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late PreferenceAssistant preferenceAssistant;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    preferenceAssistant = PreferenceAssistant(
      sharedPreferences: mockSharedPreferences,
    );
  });

  test('Given correct parameters it invokes shared preferences method', () async {
    when(() => mockSharedPreferences.setString(any(), any())).thenAnswer(
      (_) => Future.value(true),
    );

    when(() => mockSharedPreferences.setBool(any(), any())).thenAnswer(
      (_) => Future.value(true),
    );

    when(() => mockSharedPreferences.setInt(any(), any())).thenAnswer(
      (_) => Future.value(true),
    );

    preferenceAssistant.write<String>(key: 'key', value: 'value');
    preferenceAssistant.write<bool>(key: 'key1', value: true);
    preferenceAssistant.write<int>(key: 'key2', value: 123);

    verify(() => mockSharedPreferences.setString(any(), any())).called(1);
    verify(() => mockSharedPreferences.setBool(any(), any())).called(1);
    verify(() => mockSharedPreferences.setInt(any(), any())).called(1);
  });

  test('Given correct parameters it invokes shared preferences method', () async {
    when(() => mockSharedPreferences.getString(any())).thenReturn(
      'value',
    );

    when(() => mockSharedPreferences.getBool(any())).thenReturn(
      true,
    );

    when(() => mockSharedPreferences.getInt(any())).thenReturn(
      123,
    );

    preferenceAssistant.read<String>(key: 'key');
    preferenceAssistant.read<bool>(key: 'key1');
    preferenceAssistant.read<int>(key: 'key2');

    verify(() => mockSharedPreferences.getString(any())).called(1);
    verify(() => mockSharedPreferences.getBool(any())).called(1);
    verify(() => mockSharedPreferences.getInt(any())).called(1);
  });
}
