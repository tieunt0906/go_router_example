import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  PrefHelper(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Future<dynamic> getValue<T>(String key) async {
    switch (T) {
      case double:
        return _sharedPreferences.getDouble(key);
      case int:
        return _sharedPreferences.getInt(key);
      case String:
        return _sharedPreferences.getString(key);
      case List:
        return _sharedPreferences.getStringList(key);
      case bool:
        return _sharedPreferences.getBool(key);
      default:
        return _sharedPreferences.getString(key);
    }
  }

  Future<bool> setValue<T>(String key, dynamic value) {
    switch (T) {
      case double:
        return _sharedPreferences.setDouble(key, value as double);
      case int:
        return _sharedPreferences.setInt(key, value as int);
      case String:
        return _sharedPreferences.setString(key, value as String);
      case List:
        return _sharedPreferences.setStringList(key, value as List<String>);
      case bool:
        return _sharedPreferences.setBool(key, value as bool);
      default:
        return _sharedPreferences.setString(key, value as String);
    }
  }

  Future<bool> remove(String key) async {
    return _sharedPreferences.remove(key);
  }
}

class Preferences {
  Preferences._();

  static const String token = 'token';
}
