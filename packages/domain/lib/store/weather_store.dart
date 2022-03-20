import 'package:domain/preference_assistant/preference_assistant.dart';

class WeatherStore {
  const WeatherStore({
    required PreferenceAssistant preferenceAssistant,
  }) : _preferenceAssistant = preferenceAssistant;

  final PreferenceAssistant _preferenceAssistant;

  static const String _woeidKey = 'woeidKey';

  Future<void> setWoeid(int woeid) {
    return _preferenceAssistant.write<int>(key: _woeidKey, value: woeid);
  }

  int? getWoeid() {
    return _preferenceAssistant.read<int>(key: _woeidKey);
  }
}
