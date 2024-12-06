import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_thread.dart';
import 'package:threadfon/core/models/user_selection.dart';
import 'package:threadfon/core/services/logging/logger.dart';

final _logger = LogService('local_storage');

/// Класс для работы с локальным хранилищем. Кеширование удалено:
/// Данные всегда считываются из SharedPreferences.
class LocalStorage {
  LocalStorage({bool isShowLog = false}) : _isShowLog = isShowLog;

  SharedPreferences? _sharedPreferences;

  final bool _isShowLog;

  // Определение ключей в одном месте для предотвращения ошибок
  static const String _appId = '_appId';
  static const String _userSelectionKey = '_userSelection';
  static const String _userAgent = 'userAgent';
  static const String _targetUrl = '_TargetUrl';
  static const String _metricScrollPositionKey = 'scroll_position_metric';
  static const String _imperialScrollPositionKey = 'scroll_position_imperial';
  static const String _themeStateKey = '_themeState';
  static const String _languageStateKey = '_languageStateKey';

  /// Инициализация SharedPreferences.
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _logger.i('INITIALIZE LocalStorage', includeStackTrace: false);
  }

  // ******************************

  /// Сохранение положения скролла
  Future<void> setMetricScrollPosition(double position) async {
    await _setValue<double>(key: _metricScrollPositionKey, value: position);
  }

  /// Получение сохраненного положения скролла
  Future<double> getMetricScrollPosition() async {
    return await _getValue<double>(key: _metricScrollPositionKey, defaultValue: 0.0) ?? 0.0;
  }

  /// Сохранение положения скролла
  Future<void> setImperialScrollPosition(double position) async {
    await _setValue<double>(key: _imperialScrollPositionKey, value: position);
  }

  /// Получение сохраненного положения скролла
  Future<double> getImperialScrollPosition() async {
    return await _getValue<double>(key: _imperialScrollPositionKey, defaultValue: 0.0) ?? 0.0;
  }

  // ******************************
  // Методы для работы с _appId

  Future<String?> getAppId() => _getValue<String>(key: _appId);

  Future<void> setAppId(String? value) => _setValue<String>(key: _appId, value: value ?? '');

  // ******************************
  // Методы для работы с _userSelection

  Future<UserSelection> getUserSelection() async {
    final jsonString = await _getValue<String>(key: _userSelectionKey, defaultValue: '{}');
    try {
      return jsonString != null
          ? UserSelection.fromJson(json.decode(jsonString) as Map<String, dynamic>)
          : const UserSelection();
    } on Exception catch (e, s) {
      await _recordError(e, s, 'GET_USER_SELECTION', _userSelectionKey, jsonString);
      return const UserSelection();
    }
  }

  Future<void> setUserSelection(UserSelection value) async {
    try {
      final jsonString = json.encode(value.toJson());
      await _setValue<String>(key: _userSelectionKey, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET_USER_SELECTION', _userSelectionKey, value);
    }
  }

  /// Метод для обновления UserSelection с использованием функции модификации.
  Future<void> updateUserSelection(
    FutureOr<UserSelection> Function(UserSelection current) updateFn,
  ) async {
    try {
      // Получаем текущий объект UserSelection
      var currentSelection = await getUserSelection();

      // Применяем функцию обновления
      var updatedSelection = await updateFn(currentSelection);

      // Сохраняем обновленный объект
      await setUserSelection(updatedSelection);

      await _log('UPDATE_USER_SELECTION', _userSelectionKey, updatedSelection);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'UPDATE_USER_SELECTION', _userSelectionKey, null);
    }
  }

  // ******************************
  // Методы для работы с _userAgent

  Future<String?> getUserAgent() => _getValue<String>(key: _userAgent);

  Future<void> setUserAgent(String? value) => _setValue<String>(key: _userAgent, value: value ?? '');

  // ******************************
  // Методы для работы с _targetUrl

  Future<String?> getTargetUrl() => _getValue<String>(
        key: _targetUrl,
        defaultValue: 'https://unknown.com?utm_source=organic_mob',
      );

  Future<void> setTargetUrl(String? value) => _setValue<String>(key: _targetUrl, value: value ?? '');

  // ******************************
  // Методы для работы с _themeMode

  Future<ThemeState> getThemeState() async {
    final jsonString = await _getValue<String>(key: _themeStateKey);
    final defaultThemeState = ThemeState(themeMode: ThemeMode.light);

    try {
      return jsonString != null
          ? ThemeState.fromJson(json.decode(jsonString) as Map<String, dynamic>)
          : defaultThemeState;
    } on Exception catch (e, s) {
      await _recordError(e, s, 'GET_THEME_STATE', _themeStateKey, jsonString);
      return defaultThemeState;
    }
  }

  Future<void> setThemeState(ThemeState value) async {
    try {
      final jsonString = json.encode(value.toJson());
      await _setValue<String>(key: _themeStateKey, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET_THEME_STATE', _themeStateKey, value);
    }
  }

  // ******************************

  // Методы для работы с языковой конфигурацией
  Future<LanguageState> getLanguageState() async {
    final jsonString = await _getValue<String>(key: _languageStateKey);
    final defaultLanguageState = LanguageState(
      enumLang: EnumLang.values.firstWhere(
        (e) => e.name == PlatformDispatcher.instance.locale.languageCode,
        orElse: () => EnumLang.en,
      ),
    );

    try {
      return jsonString != null
          ? LanguageState.fromJson(json.decode(jsonString) as Map<String, dynamic>)
          : defaultLanguageState;
    } on Exception catch (e, s) {
      await _recordError(e, s, 'GET_LANGUAGE_STATE', _languageStateKey, jsonString);
      return defaultLanguageState;
    }
  }

  Future<void> setLanguageState(LanguageState value) async {
    try {
      final jsonString = json.encode(value.toJson());
      await _setValue<String>(key: _languageStateKey, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET_LANGUAGE_STATE', _languageStateKey, value);
    }
  }

  // ******************************
  // Универсальные методы для хранения и получения данных

  Future<void> _setValue<T>({
    required String key,
    required T value,
  }) async {
    try {
      _ensureInitialized();

      if (value is String) {
        await _sharedPreferences!.setString(key, value);
      } else if (value is bool) {
        await _sharedPreferences!.setBool(key, value);
      } else if (value is int) {
        await _sharedPreferences!.setInt(key, value);
      } else if (value is double) {
        await _sharedPreferences!.setDouble(key, value);
      } else if (value is List<String>) {
        await _sharedPreferences!.setStringList(key, value);
      } else {
        throw Exception('Unsupported type');
      }

      await _log('SET', key, value);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET', key, value);
    }
  }

  /// Универсальный метод для получения значения из хранилища.
  Future<T?> _getValue<T>({
    required String key,
    T? defaultValue,
    bool forceRefresh = false,
  }) async {
    try {
      _ensureInitialized();
      T? result = _getFromSharedPreferences<T>(key, null);

      // Если результат null и есть defaultValue, сохраняем и возвращаем defaultValue
      if (result == null && defaultValue != null) {
        await _setValue<T>(key: key, value: defaultValue);
        return defaultValue;
      }

      // Возвращаем полученное значение или defaultValue (если result == null)
      return result ?? defaultValue;
    } on Exception catch (e, s) {
      await _recordError(e, s, 'GET', key, defaultValue);
      return defaultValue;
    }
  }

  /// Получение значения из SharedPreferences.
  T? _getFromSharedPreferences<T>(String key, T? defaultValue) {
    if (T == String) {
      return _sharedPreferences!.getString(key) as T? ?? defaultValue;
    } else if (T == bool) {
      return _sharedPreferences!.getBool(key) as T? ?? defaultValue;
    } else if (T == int) {
      return _sharedPreferences!.getInt(key) as T? ?? defaultValue;
    } else if (T == double) {
      return _sharedPreferences!.getDouble(key) as T? ?? defaultValue;
    } else if (T == List<String>) {
      return _sharedPreferences!.getStringList(key) as T? ?? defaultValue;
    }
    return defaultValue;
  }

  // ******************************
  // Методы для работы с JSON-данными

  /// Метод для сохранения JSON-объекта в хранилище.
  Future<void> setJson({
    required String key,
    required Map<String, dynamic> value,
  }) async {
    try {
      final jsonString = json.encode(value);
      await _setValue<String>(key: key, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET_JSON', key, value);
    }
  }

  /// Метод для получения JSON-объекта из хранилища.
  Future<Map<String, dynamic>?> getJson({
    required String key,
    defaultValue = const <String, dynamic>{},
  }) async {
    final jsonString = await _getValue<String>(key: key, defaultValue: json.encode(defaultValue));
    try {
      return jsonString != null ? json.decode(jsonString) as Map<String, dynamic> : null;
    } on Exception catch (e, s) {
      await _recordError(e, s, 'GET_JSON', key, jsonString);
      return null;
    }
  }

  // ******************************
  // Логирование и обработка ошибок

  /// Логирование действия, если включен режим отображения логов.
  Future<void> _log(String action, String key, dynamic value) async {
    if (_isShowLog) {
      _logger.i('$action > $key, Value: $value', includeStackTrace: false);
    }
  }

  /// Запись ошибки с детализацией действия, ключа и значения.
  Future<void> _recordError(
    Object exception,
    StackTrace stackTrace,
    String action,
    String key,
    dynamic value,
  ) async {
    _logger.e(
      '$action > $key, Value: $value',
      error: exception,
      stackTrace: stackTrace,
    );
  }

  // ******************************
  // Очистка всех данных

  /// Полная очистка всех данных из асинхронного и кешированного хранилища.
  Future<void> clearAll() async {
    try {
      _ensureInitialized();

      await _sharedPreferences!.clear();
      await _log('CLEAR', 'All Data', 'All data cleared');
    } on Exception catch (e, s) {
      await _recordError(e, s, 'CLEAR', 'All Data', 'Failed to clear all data');
    }
  }

  // ******************************
  /// Проверка инициализации хранилищ
  void _ensureInitialized() {
    if (_sharedPreferences == null) {
      throw Exception('LocalStorage not initialized. Call initialize() before using.');
    }
  }
}
