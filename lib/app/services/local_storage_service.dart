import 'dart:developer';

// Package imports:
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageServices {
  LocalStorageServices._();

  static final LocalStorageServices _instance = LocalStorageServices._();
  static LocalStorageServices get service => _instance;
  static SharedPreferences? _prefs;
  SharedPreferences? get instance => _prefs;

  ///initializing
  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    assert(_prefs != null, '_prefs must not be null');
  }

  static const String _info = 'local storage';

  /// Helper functions for saving data
  Future<void> saveString(String key, String value) async {
    log('SET $_info > $key = $value');
    await _prefs?.setString(key, value);
  }

  Future<void> saveBool(String key, bool value) async {
    log('SET $_info > $key = $value');
    await _prefs?.setBool(key, value);
  }

  Future<void> saveDouble(String key, double value) async {
    log('SET $_info > $key = $value');
    await _prefs?.setDouble(key, value);
  }

  Future<void> saveInt(String key, int value) async {
    log('SET $_info > $key = $value');
    await _prefs?.setInt(key, value);
  }

  String getString(String key, {String defaultValue = ''}) {
    final val = _prefs?.getString(key) ?? defaultValue;

    log('GET $_info > $key = $val');

    return val;
  }

  int getIntData(String key, {int defaultValue = -1}) {
    final val = _prefs?.getInt(key) ?? defaultValue;
    log('GET $_info > $key = $val');

    return val;
  }

  double getDouble(String key, {double defaultValue = -1.0}) {
    final val = _prefs?.getDouble(key) ?? defaultValue;
    log('GET $_info > $key = $val');

    return val;
  }

  bool isNull(String key) {
    final val = _prefs?.get(key);
    bool result;

    if (val == null) {
      result = true;
    } else {
      result = false;
    }
    log('GET  $_info | isNull $result | > $key = $val');

    return result;
  }

  bool getBoolData(String key, {bool defaultValue = false}) {
    final val = _prefs?.getBool(key) ?? defaultValue;
    log('GET $_info > $key = $val');

    return val;
  }

  Future<void> clearAll() async {
    await _prefs?.clear();
  }
}
