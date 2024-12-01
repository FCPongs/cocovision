import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static final SharedPreferencesHelper _instance =
      SharedPreferencesHelper._internal();
  SharedPreferences? _preferences;

  SharedPreferencesHelper._internal();

  factory SharedPreferencesHelper() {
    return _instance;
  }

  Future<void> initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
  }
  int getCounter(String key) {
  return _preferences?.getInt(key) ?? 0;
  }

  void incrementCounter(String key) {
    final currentValue = _preferences?.getInt(key) ?? 0;
    _preferences?.setInt(key, currentValue + 1);
  }

  // Set integer value
  void setIntValue(String key, int value) {
    _preferences?.setInt(key, value);
  }

  // Get integer value
  int? getIntValue(String key) {
    return _preferences?.getInt(key);
  }

  // Existing methods
  void setValue(String key, String value) {
    _preferences?.setString(key, value);
  }

  String? getValue(String key) {
    return _preferences?.getString(key);
  }
}
