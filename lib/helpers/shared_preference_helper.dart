import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static Future<void> setPreference<T>(String key, dynamic value) async {
    if (value.runtimeType != T) {
      throw Exception('type $T is not type of ${value.runtimeType}');
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (T == String) {
      await prefs.setString(key, value);
    } else if (T == bool) {
      await prefs.setBool(key, value);
    } else if (T == double) {
      await prefs.setDouble(key, value);
    } else if (T == int) {
      await prefs.setInt(key, value);
    } else if (T == List<String>) {
      await prefs.setStringList(key, value);
    }
  }

  static Future<T?> getPreference<T>(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (T == String) {
      return prefs.getString(key) as T?;
    } else if (T == bool) {
      return prefs.getBool(key) as T?;
    } else if (T == double) {
      return prefs.getDouble(key) as T?;
    } else if (T == int) {
      return prefs.getInt(key) as T?;
    } else if (T == List<String>) {
      return prefs.getStringList(key) as T?;
    }
    return null;
  }

  static Future<void> removePreference(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  static Future<void> removeAllPreference() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
