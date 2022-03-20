import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenceAssistant {
  const PreferenceAssistant({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  final SharedPreferences _sharedPreferences;

  Future<bool> write<@required T>({required String key, required T value}) async {
    if (value is String) {
      return _sharedPreferences.setString(key, value);
    } else if (value is bool) {
      return _sharedPreferences.setBool(key, value);
    } else if(value is int) {
      return _sharedPreferences.setInt(key, value);
    }
    return false;
  }

  T? read<@required T>({required String key}) {
    if (T == String) {
      // ignore: avoid_as
      return _sharedPreferences.getString(key) as T?;
    } else if (T == bool) {
      // ignore: avoid_as
      return _sharedPreferences.getBool(key) as T?;
    } else if(T == int) {
      // ignore: avoid_as
      return _sharedPreferences.getInt(key) as T?;
    }
    return null;
  }

  Future<bool> deleteAll() async => _sharedPreferences.clear();
}
