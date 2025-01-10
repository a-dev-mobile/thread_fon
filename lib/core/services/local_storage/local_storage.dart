import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/core/constant/enum_lang.dart';
import 'package:threadfon/core/models/core_user_selection.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/utils/device_id_generator.dart';
import 'package:threadfon/features/03_metric_threads/core/models/metric_user_selection.dart';
import 'package:threadfon/features/04_imperial_threads/models/imperial_user_selection.dart';
import 'package:threadfon/features/05_trapezoidal_threads/core/models/trapezoidal_user_selection.dart';

final LogService _logger = LogService('local_storage');

/// Класс для работы с локальным хранилищем. Кеширование удалено:
/// Данные всегда считываются из SharedPreferences.
class LocalStorage {
  LocalStorage({bool isShowLog = false}) : _isShowLog = isShowLog;

  SharedPreferences? _sharedPreferences;

  final bool _isShowLog;

  // Определение ключей в одном месте для предотвращения ошибок
  static const String _appId = '_appId';
  static const String _metricUserSelectionKey = '_metricUserSelection';
  static const String _coreUserSelectionKey = '_userSelection'; // Новый ключ
  static const String _imperialUserSelectionKey = '_imperialUserSelection';
  static const String _userAgent = 'userAgent';
  static const String _targetUrl = '_TargetUrl';
  static const String _metricScrollPositionKey = 'scroll_position_metric';
  static const String _imperialScrollPositionKey = 'scroll_position_imperial';
  static const String _themeStateKey = '_themeState';
  static const String _languageStateKey = '_languageStateKey';
  static const String _currentUserIdKey = '_currentUserId';
  static const String _lastActivityTimestampKey = '_lastActivityTimestamp';
  static const String _currentRouteKey = '_currentRoute';
  static const String _lastErrorTimestampKey = '_lastErrorTimestamp';
  static const String _errorCountLastHourKey = '_errorCountLastHour';

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
    return await _getValue<double>(
            key: _metricScrollPositionKey, defaultValue: 0.0) ??
        0.0;
  }

  /// Сохранение положения скролла
  Future<void> setImperialScrollPosition(double position) async {
    await _setValue<double>(key: _imperialScrollPositionKey, value: position);
  }

  /// Получение сохраненного положения скролла
  Future<double> getImperialScrollPosition() async {
    return await _getValue<double>(
            key: _imperialScrollPositionKey, defaultValue: 0.0) ??
        0.0;
  }

  ///
  ///
  ///
  ///

  // ******************************
  // ******************************
  // Методы для работы с _appId

  Future<String?> getAppId() => _getValue<String>(key: _appId);

  Future<void> setAppId(String? value) =>
      _setValue<String>(key: _appId, value: value ?? '');

  // ******************************
  // Методы для работы с _metricUserSelection

  Future<MetricUserSelection> getMetricUserSelection() async {
    final String? jsonString = await _getValue<String>(
        key: _metricUserSelectionKey, defaultValue: '{}');
    try {
      return jsonString != null
          ? MetricUserSelection.fromJson(
              json.decode(jsonString) as Map<String, dynamic>)
          : const MetricUserSelection();
    } on Exception catch (e, s) {
      await _recordError(e, s, 'GET_METRIC_USER_SELECTION',
          _metricUserSelectionKey, jsonString);

      return const MetricUserSelection();
    }
  }

  Future<void> setMetricUserSelection(MetricUserSelection value) async {
    try {
      final String jsonString = json.encode(value.toJson());
      await _setValue<String>(key: _metricUserSelectionKey, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(
          e, s, 'SET_METRIC_USER_SELECTION', _metricUserSelectionKey, value);
    }
  }

  /// Метод для обновления MetricUserSelection с использованием функции модификации.
  Future<void> updateMetricUserSelection(
    FutureOr<MetricUserSelection> Function(MetricUserSelection current)
        updateFn,
  ) async {
    try {
      // Получаем текущий объект MetricUserSelection
      MetricUserSelection currentSelection = await getMetricUserSelection();

      // Применяем функцию обновления
      MetricUserSelection updatedSelection = await updateFn(currentSelection);

      // Сохраняем обновленный объект
      await setMetricUserSelection(updatedSelection);

      await _log('UPDATE_METRIC_USER_SELECTION', _metricUserSelectionKey,
          updatedSelection);
    } on Exception catch (e, s) {
      await _recordError(
          e, s, 'UPDATE_METRIC_USER_SELECTION', _metricUserSelectionKey, null);
    }
  }

  // ******************************
  // Методы для работы с _userSelection

  Future<CoreUserSelection> getCoreUserSelection() async {
    final String? jsonString =
        await _getValue<String>(key: _coreUserSelectionKey, defaultValue: '{}');
    try {
      return jsonString != null
          ? CoreUserSelection.fromJson(
              json.decode(jsonString) as Map<String, dynamic>)
          : const CoreUserSelection();
    } on Exception catch (e, s) {
      await _recordError(
          e, s, 'GET_CORE_USER_SELECTION', _coreUserSelectionKey, jsonString);

      return const CoreUserSelection();
    }
  }

  Future<void> setCoreUserSelection(CoreUserSelection value) async {
    try {
      final String jsonString = json.encode(value.toJson());
      await _setValue<String>(key: _coreUserSelectionKey, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(
          e, s, 'SET_CORE_USER_SELECTION', _coreUserSelectionKey, value);
    }
  }

  /// Метод для обновления UserSelection с использованием функции модификации.
  Future<void> updateCoreUserSelection(
    FutureOr<CoreUserSelection> Function(CoreUserSelection current) updateFn,
  ) async {
    try {
      // Получаем текущий объект UserSelection
      CoreUserSelection currentSelection = await getCoreUserSelection();

      // Применяем функцию обновления
      CoreUserSelection updatedSelection = await updateFn(currentSelection);

      // Сохраняем обновленный объект
      await setCoreUserSelection(updatedSelection);

      await _log('UPDATE_CORE_USER_SELECTION', _coreUserSelectionKey,
          updatedSelection);
    } on Exception catch (e, s) {
      await _recordError(
          e, s, 'UPDATE_CORE_USER_SELECTION', _coreUserSelectionKey, null);
    }
  }

  // ******************************
  // Методы для работы с _imperialUserSelection

  Future<ImperialUserSelection> getImperialUserSelection() async {
    final String? jsonString = await _getValue<String>(
        key: _imperialUserSelectionKey, defaultValue: '{}');
    try {
      return jsonString != null
          ? ImperialUserSelection.fromJson(
              json.decode(jsonString) as Map<String, dynamic>)
          : const ImperialUserSelection();
    } on Exception catch (e, s) {
      await _recordError(e, s, 'GET_IMPERIAL_USER_SELECTION',
          _imperialUserSelectionKey, jsonString);

      return const ImperialUserSelection();
    }
  }

  Future<void> setImperialUserSelection(ImperialUserSelection value) async {
    try {
      final String jsonString = json.encode(value.toJson());
      await _setValue<String>(
          key: _imperialUserSelectionKey, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET_IMPERIAL_USER_SELECTION',
          _imperialUserSelectionKey, value);
    }
  }

  /// Метод для обновления ImperialUserSelection с использованием функции модификации.
  Future<void> updateImperialUserSelection(
    FutureOr<ImperialUserSelection> Function(ImperialUserSelection current)
        updateFn,
  ) async {
    try {
      // Получаем текущий объект ImperialUserSelection
      ImperialUserSelection currentSelection = await getImperialUserSelection();

      // Применяем функцию обновления
      ImperialUserSelection updatedSelection = await updateFn(currentSelection);

      // Сохраняем обновленный объект
      await setImperialUserSelection(updatedSelection);

      await _log('UPDATE_IMPERIAL_USER_SELECTION', _imperialUserSelectionKey,
          updatedSelection);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'UPDATE_IMPERIAL_USER_SELECTION',
          _imperialUserSelectionKey, null);
    }
  }
// ******************************
// ******************************
// ******************************
// ******************************
// **********trapezoidal********
// ******************************
// ******************************
// ******************************
// ******************************

  static const String _trapezoidalScrollPosition = '_trapezoidalScrollPosition';

  Future<void> setTrapezoidalScrollPosition(double position) async {
    await _setValue<double>(key: _trapezoidalScrollPosition, value: position);
  }

  Future<double> getTrapezoidalScrollPosition() async {
    return await _getValue<double>(
            key: _trapezoidalScrollPosition, defaultValue: 0.0) ??
        0.0;
  }

  static const String _trapezoidalUserSelection = '_trapezoidalUserSelection';

  Future<TrapezoidalUserSelection> getTrapezoidalUserSelection() async {
    final String? jsonString = await _getValue<String>(
        key: _trapezoidalUserSelection, defaultValue: '{}');
    try {
      return jsonString != null
          ? TrapezoidalUserSelection.fromJson(
              json.decode(jsonString) as Map<String, dynamic>)
          : const TrapezoidalUserSelection();
    } on Exception catch (e, s) {
      await _recordError(e, s, 'GET_TRAPEZOIDAL_USER_SELECTION',
          _trapezoidalUserSelection, jsonString);

      return const TrapezoidalUserSelection();
    }
  }

  Future<void> setTrapezoidalUserSelection(
      TrapezoidalUserSelection value) async {
    try {
      final String jsonString = json.encode(value.toJson());
      await _setValue<String>(
          key: _trapezoidalUserSelection, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET_TRAPEZOIDAL_USER_SELECTION',
          _trapezoidalUserSelection, value);
    }
  }

  // ******************************

  Future<void> updateTrapezoidalUserSelection(
    FutureOr<TrapezoidalUserSelection> Function(
            TrapezoidalUserSelection current)
        updateFn,
  ) async {
    try {
      // Получаем текущий объект ImperialUserSelection
      TrapezoidalUserSelection currentSelection =
          await getTrapezoidalUserSelection();

      // Применяем функцию обновления
      TrapezoidalUserSelection updatedSelection =
          await updateFn(currentSelection);

      // Сохраняем обновленный объект
      await setTrapezoidalUserSelection(updatedSelection);

      await _log('UPDATE_TRAPEZOIDAL_USER_SELECTION', _trapezoidalUserSelection,
          updatedSelection);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'UPDATE_TRAPEZOIDAL_USER_SELECTION',
          _trapezoidalUserSelection, null);
    }
  }

  // ******************************
// ******************************
// ******************************
// ******************************
// ******************************
// ******************************
// ******************************
// ******************************
// ******************************

  // ******************************
  // Методы для работы с _userAgent

  Future<String?> getUserAgent() => _getValue<String>(key: _userAgent);

  Future<void> setUserAgent(String? value) =>
      _setValue<String>(key: _userAgent, value: value ?? '');

  // ******************************
  // Методы для работы с _targetUrl

  Future<String?> getTargetUrl() => _getValue<String>(
        key: _targetUrl,
        defaultValue: 'https://unknown.com?utm_source=organic_mob',
      );

  Future<void> setTargetUrl(String? value) =>
      _setValue<String>(key: _targetUrl, value: value ?? '');

  // ******************************
  // Методы для работы с _themeMode

  Future<ThemeState> getThemeState() async {
    final String? jsonString = await _getValue<String>(key: _themeStateKey);
    const ThemeState defaultThemeState = ThemeState(themeMode: ThemeMode.light);

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
      final String jsonString = json.encode(value.toJson());
      await _setValue<String>(key: _themeStateKey, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET_THEME_STATE', _themeStateKey, value);
    }
  }

  // ******************************

  // Методы для работы с языковой конфигурацией
  Future<LanguageState> getLanguageState() async {
    final String? jsonString = await _getValue<String>(key: _languageStateKey);
    final LanguageState defaultLanguageState = LanguageState(
      enumLang: EnumLang.values.firstWhere(
        (EnumLang e) =>
            e.name == PlatformDispatcher.instance.locale.languageCode,
        orElse: () => EnumLang.en,
      ),
    );

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
      final String jsonString = json.encode(value.toJson());
      await _setValue<String>(key: _languageStateKey, value: jsonString);
    } on Exception catch (e, s) {
      await _recordError(e, s, 'SET_LANGUAGE_STATE', _languageStateKey, value);
    }
  }

  // ******************************
  // Методы для работы с текущим userId

  Future<String?> getCurrentUserId() =>
      _getValue<String>(key: _currentUserIdKey);

  /// Инициализирует или получает существующий ID пользователя
  Future<String> ensureUserId() async {
    String? userId = await getCurrentUserId();
    if (userId == null || userId.isEmpty) {
      userId = await DeviceIdGenerator.generateUniqueDeviceId();
      await setCurrentUserId(userId);
    }
    return userId;
  }

  /// Сохраняет ID пользователя. Если значение null, генерирует новый ID
  Future<void> setCurrentUserId(String? value) async {
    final String userId =
        value ?? await DeviceIdGenerator.generateUniqueDeviceId();
    await _setValue<String>(
      key: _currentUserIdKey,
      value: userId,
    );
  }

  // ******************************
  // Методы для работы с _lastActivityTimestamp

  Future<String?> getLastActivityTimestamp() =>
      _getValue<String>(key: _lastActivityTimestampKey);

  Future<void> setLastActivityTimestamp(String timestamp) =>
      _setValue<String>(key: _lastActivityTimestampKey, value: timestamp);

  // Методы для работы с _currentRoute

  Future<String?> getCurrentRoute() => _getValue<String>(key: _currentRouteKey);

  Future<void> setCurrentRoute(String route) =>
      _setValue<String>(key: _currentRouteKey, value: route);

  // Методы для работы с _lastErrorTimestamp

  Future<String?> getLastErrorTimestamp() =>
      _getValue<String>(key: _lastErrorTimestampKey);

  Future<void> setLastErrorTimestamp(String timestamp) =>
      _setValue<String>(key: _lastErrorTimestampKey, value: timestamp);

  // Методы для работы с _errorCountLastHour

  Future<int?> getErrorCountLastHour() =>
      _getValue<int>(key: _errorCountLastHourKey);

  Future<void> setErrorCountLastHour(int count) =>
      _setValue<int>(key: _errorCountLastHourKey, value: count);

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
      final String jsonString = json.encode(value);
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
    final String? jsonString = await _getValue<String>(
        key: key, defaultValue: json.encode(defaultValue));
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
    Object e,
    StackTrace s,
    String action,
    String key,
    dynamic value,
  ) async {
    _logger.e(
      '$action > $key, Value: $value',
      error: e,
      stackTrace: s,
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
      throw Exception(
          'LocalStorage not initialized. Call initialize() before using.');
    }
  }
}
