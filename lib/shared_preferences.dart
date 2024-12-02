import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance = SharedPreferencesHelper._internal();
  SharedPreferences? _preferences;

  SharedPreferencesHelper._internal();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  // Initialize SharedPreferences instance
  Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }

  // Increment counter by a specified value
  Future<void> incrementCounterBy(String key, int increment) async {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized");
    }
    final currentValue = _preferences!.getInt(key) ?? 0;
    await _preferences!.setInt(key, currentValue + increment);
  }

//Printing purposes
  int getCounter(String key) {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized");
    }
    return _preferences!.getInt(key) ?? 0;
  }

  Future<void> incrementCounter(String key) async {
    await incrementCounterBy(key, 1);
  }

  Future<void> setIntValue(String key, int value) async {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized");
    }
    await _preferences!.setInt(key, value);
  }

  int? getIntValue(String key) {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized");
    }
    return _preferences!.getInt(key);
  }

  Future<void> setValue(String key, String value) async {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized");
    }
    await _preferences!.setString(key, value);
  }

  String? getValue(String key) {
    if (_preferences == null) {
      throw Exception("SharedPreferences not initialized");
    }
    return _preferences!.getString(key);
  }
}
