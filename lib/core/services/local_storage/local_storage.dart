import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/models/user_selection.dart';
import 'package:threadfon/core/services/logging/logger.dart';

final _logger = LogService('local_storage');

/// Класс для работы с локальным хранилищем, включая асинхронное и кешированное хранилище.
/// Обеспечивает сохранение и получение данных с возможностью кеширования и обработки ошибок.
class LocalStorage {
  LocalStorage({bool isShowLog = false}) : _isShowLog = isShowLog;

  SharedPreferences? _sharedPreferences;
  SharedPreferencesWithCache? _cachePreferences;

  final bool _isShowLog;
  DateTime _lastCacheUpdate = DateTime.now();

  static const Duration _cacheDuration = Duration(minutes: 5);

  // Определение ключей в одном месте для предотвращения ошибок
  static const String _appId = '_appId';
  static const String _userSelectionKey = '_userSelection';
  static const String _userAgent = 'userAgent';
  static const String _targetUrl = '_TargetUrl';

  /// Инициализация асинхронных и кешированных настроек.
  Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _cachePreferences = await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(
        allowList: <String>{
          _appId,
          _userAgent,
          _targetUrl,
          _userSelectionKey,
          _themeStateKey,
          _languageStateKey,
          _scrollPositionKey
        },
      ),
    );
    _logger.i('INITIALIZE LocalStorage', includeStackTrace: false);
  }

  // ******************************

  // Ключи для сохранения скролла
  static const String _scrollPositionKey = 'scroll_position_';

  /// Сохранение положения скролла
  Future<void> setScrollPosition(double position) async {
    await _setValue<double>(key: _scrollPositionKey, value: position);
  }

  /// Получение сохраненного положения скролла
  Future<double?> getScrollPosition() async {
    return await _getValue<double>(
      key: _scrollPositionKey,
      defaultValue: 0.0,
    );
  }

  // ******************************
  // Методы для работы с _appId

  Future<String?> getAppId({bool forceRefresh = false}) => _getValue<String>(
        key: _appId,
        forceRefresh: forceRefresh,
      );

  Future<void> setAppId(String? value) =>
      _setValue<String>(key: _appId, value: value ?? '');

  // ******************************
  // Методы для работы с _userSelection

  Future<UserSelection> getUserSelection({bool forceRefresh = false}) async {
    final jsonString = await _getValue<String>(
      key: _userSelectionKey,
      forceRefresh: forceRefresh,
      defaultValue: '{}',
    );
    try {
      return jsonString != null
          ? UserSelection.fromJson(
              json.decode(jsonString) as Map<String, dynamic>)
          : const UserSelection();
    } on Exception catch (e, s) {
      await _recordError(
          e, s, 'GET_USER_SELECTION', _userSelectionKey, jsonString);
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
      await _recordError(
          e, s, 'UPDATE_USER_SELECTION', _userSelectionKey, null);
    }
  }
  // ******************************
  // Методы для работы с _userAgent

  Future<String?> getUserAgent({bool forceRefresh = false}) =>
      _getValue<String>(
        key: _userAgent,
        forceRefresh: forceRefresh,
      );

  Future<void> setUserAgent(String? value) =>
      _setValue<String>(key: _userAgent, value: value ?? '');

  // ******************************
  // Методы для работы с _targetUrl

  Future<String?> getTargetUrl({bool forceRefresh = false}) =>
      _getValue<String>(
        key: _targetUrl,
        forceRefresh: forceRefresh,
        defaultValue: 'https://unknown.com?utm_source=organic_mob',
      );

  Future<void> setTargetUrl(String? value) =>
      _setValue<String>(key: _targetUrl, value: value ?? '');

  // ******************************
  // Методы для работы с _themeMode
  static const String _themeStateKey = '_themeState';

  Future<ThemeState> getThemeState({bool forceRefresh = false}) async {
    final jsonString = await _getValue<String>(
      key: _themeStateKey,
      forceRefresh: forceRefresh,
      defaultValue: null,
    );
    final defaultThemeState = ThemeState(themeMode: ThemeMode.dark);

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

  // ******************************
  // Методы для работы с _themeMode
  static const String _languageStateKey = '_languageStateKey';

  Future<LanguageState> getLanguageState({bool forceRefresh = false}) async {
    final jsonString = await _getValue<String>(
      key: _languageStateKey,
      forceRefresh: forceRefresh,
      defaultValue: null,
    );

    final defaultLanguageState = LanguageState(
        enumLang: EnumLang.values.firstWhere(
      (e) => e.name == PlatformDispatcher.instance.locale.languageCode,
      orElse: () => EnumLang.en,
    ));
    try {
      return jsonString != null
          ? LanguageState.fromJson(
              json.decode(jsonString) as Map<String, dynamic>)
          : defaultLanguageState;
    } on Exception catch (e, s) {
      await _recordError(
          e, s, 'GET_LANGUAGE_STATE', _languageStateKey, jsonString);
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

  /// Универсальный метод для сохранения значения в хранилище.
  Future<void> _setValue<T>({
    required String key,
    required T value,
  }) async {
    try {
      _ensureInitialized();

      if (value is String ||
          value is bool ||
          value is int ||
          value is double ||
          value is List<String>) {
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
        }

        if (await _isValidKey(key)) {
          if (value is String) {
            await _cachePreferences!.setString(key, value);
          } else if (value is bool) {
            await _cachePreferences!.setBool(key, value);
          } else if (value is int) {
            await _cachePreferences!.setInt(key, value);
          } else if (value is double) {
            await _cachePreferences!.setDouble(key, value);
          } else if (value is List<String>) {
            await _cachePreferences!.setStringList(key, value);
          }
        }

        await _log('SET', key, value);
        _lastCacheUpdate = DateTime.now();
      } else {
        throw Exception('Unsupported type');
      }
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

      if (!await _isValidKey(key)) {
        return _getFromSharedPreferences<T>(key, defaultValue);
      }

      if (forceRefresh ||
          DateTime.now().difference(_lastCacheUpdate) > _cacheDuration) {
        await _cachePreferences!.reloadCache();
        _lastCacheUpdate = DateTime.now();
      }

      final cachedValue = _getFromCache<T>(key);
      if (cachedValue != null) {
        return cachedValue;
      }

      return _getFromSharedPreferences<T>(key, defaultValue);
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

  /// Получение значения из кеша.
  T? _getFromCache<T>(String key) {
    if (T == String) {
      return _cachePreferences!.getString(key) as T?;
    } else if (T == bool) {
      return _cachePreferences!.getBool(key) as T?;
    } else if (T == int) {
      return _cachePreferences!.getInt(key) as T?;
    } else if (T == double) {
      return _cachePreferences!.getDouble(key) as T?;
    } else if (T == List<String>) {
      return _cachePreferences!.getStringList(key) as T?;
    }
    return null;
  }

  // ******************************
  /// Проверка наличия ключа в allowList с обработкой ArgumentError
  Future<bool> _isValidKey(String key) async {
    try {
      return _cachePreferences!.containsKey(key);
    } on Exception catch (e) {
      if (e is ArgumentError) {
        await _log('WARN', key,
            'Key is not included in the PreferencesFilter allowlist');
        return false;
      }
      rethrow; // Если это не ArgumentError, выбрасываем дальше
    }
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
    required bool forceRefresh,
    defaultValue = const <String, dynamic>{},
  }) async {
    final jsonString = await _getValue<String>(
      key: key,
      forceRefresh: forceRefresh,
      defaultValue: defaultValue,
    );
    try {
      return jsonString != null
          ? json.decode(jsonString) as Map<String, dynamic>
          : null;
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
      await _cachePreferences!.clear();
      await _log('CLEAR', 'All Data', 'All data cleared');
    } on Exception catch (e, s) {
      await _recordError(e, s, 'CLEAR', 'All Data', 'Failed to clear all data');
    }
  }

  // ******************************
  /// Проверка инициализации хранилищ
  void _ensureInitialized() {
    if (_sharedPreferences == null || _cachePreferences == null) {
      throw Exception(
          'LocalStorage not initialized. Call initialize() before using.');
    }
  }
}
