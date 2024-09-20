/* 

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';


import 'app_log.dart';

 class AppStorage {
  static const String _info = 'local storage';

  Future<void> setString(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);

    log.w('SET $_info > $key = $value');
  }

  Future<String> getString(String key, {String def = ''}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getString(key);
    val ??= def;

    log.w('GET $_info > $key = $val');
    return val;
  }

  Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);

    log.w('SET $_info > $key = $value');
  }

  Future<double> getDouble(String key, [double defaultValue = 0.0]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getDouble(key);
    val ??= defaultValue;

    log.w('GET $_info > $key = $val');
    return val;
  }

  Future<void> setDouble(String key, double value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);

    log.w('SET $_info > $key = $value');
  }

  Future<bool> getBool(String key, [bool defaultValue = false]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getBool(key);
    val ??= defaultValue;

    log.w('GET $_info > $key = $val');
    return val;
  }

  Future<void> setInt(String key, int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);

    log.w('SET $_info > $key = $value');
  }

  Future<int> getInt(String key, [int defaultValue = 0]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.getInt(key);
    val ??= defaultValue;

    log.w('GET $_info > $key = $val');
    return val;
  }

  Future<bool> isNull(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var val = prefs.get(key);
    bool result;

    if (val == null) {
      result = true;
    } else {
      result = false;
    }
    log.w('GET  $_info | isNull $result | > $key = $val');
    return result;
  }

  Future<void> clearAll() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
 */
