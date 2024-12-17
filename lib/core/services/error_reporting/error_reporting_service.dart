import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'dart:io' show Platform, ProcessInfo;
import 'package:connectivity_plus/connectivity_plus.dart';

// Глобальный экземпляр ErrorReportingService
late ErrorReportingService globalErrorReporting;

final LogService _logger = LogService('ErrorReportingService');

class ErrorReportingService {
  final ApiService _apiService;
  final LocalStorage _localStorage;

  // Поля для кэширования информации о приложении и устройстве
  late final String _appName;
  late final String _packageName;
  late final String _appVersion;
  late final String _buildNumber;
  late final String _deviceModel;
  late final String _osVersion;
  late final bool _isPhysicalDevice;
  late final String _platform;
  late final bool _isDebugMode;
  late final String _systemLocale;

  ErrorReportingService._internal({
    required ApiService apiService,
    required LocalStorage localStorage,
    required String appName,
    required String packageName,
    required String appVersion,
    required String buildNumber,
    required String deviceModel,
    required String osVersion,
    required bool isPhysicalDevice,
    required String platform,
    required bool isDebugMode,
    required String systemLocale,
  })  : _apiService = apiService,
        _localStorage = localStorage,
        _appName = appName,
        _packageName = packageName,
        _appVersion = appVersion,
        _buildNumber = buildNumber,
        _deviceModel = deviceModel,
        _osVersion = osVersion,
        _isPhysicalDevice = isPhysicalDevice,
        _platform = platform,
        _isDebugMode = isDebugMode,
        _systemLocale = systemLocale;

  /// Инициализирует глобальный экземпляр сервиса.
  ///
  /// Собирает информацию о приложении и устройстве.
  static Future<ErrorReportingService> initialize({
    required ApiService apiService,
    required LocalStorage localStorage,
  }) async {
    final packageInfo = await PackageInfo.fromPlatform();

    // Получаем информацию об устройстве
    final deviceInfoPlugin = DeviceInfoPlugin();
    String deviceModel = 'Unknown';
    String osVersion = 'Unknown';
    bool isPhysicalDevice = false;
    String platform = defaultTargetPlatform.toString();

    try {
      if (Platform.isAndroid) {
        final androidInfo = await deviceInfoPlugin.androidInfo;
        deviceModel = '${androidInfo.manufacturer} ${androidInfo.model}';
        osVersion =
            'Android ${androidInfo.version.release} (SDK ${androidInfo.version.sdkInt})';
        isPhysicalDevice = androidInfo.isPhysicalDevice;
      } else if (Platform.isIOS) {
        final iosInfo = await deviceInfoPlugin.iosInfo;
        deviceModel = iosInfo.utsname.machine;
        osVersion = '${iosInfo.systemName} ${iosInfo.systemVersion}';
        isPhysicalDevice = iosInfo.isPhysicalDevice;
      } else {
        // Другие платформы
        final info = await deviceInfoPlugin.deviceInfo;
        deviceModel = info.data['name']?.toString() ?? 'Unknown Device';
        osVersion = info.data['version']?.toString() ?? 'Unknown OS';
        // Для web или desktop isPhysicalDevice не применимо
        isPhysicalDevice = false;
      }
    } catch (e) {
      // Если не удалось получить устройство, оставляем значения по умолчанию
      _logger.e('Failed to get device info', error: e);
    }

    // Получаем информацию о текущей локали системы
    String systemLocale = 'Unknown';
    try {
      // Доступ к локали может быть ограничен в некоторых платформах.
      // Если есть другой механизм получения локали - используйте его.
      // Ниже просто пример, как можно получить локаль через платформенные каналы
      // ignore: deprecated_member_use
      final locale = WidgetsBinding.instance.window.locale;
      systemLocale = locale.toLanguageTag();
    } catch (_) {}

    final isDebugMode = kDebugMode;

    globalErrorReporting = ErrorReportingService._internal(
      apiService: apiService,
      localStorage: localStorage,
      appName: packageInfo.appName,
      packageName: packageInfo.packageName,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      deviceModel: deviceModel,
      osVersion: osVersion,
      isPhysicalDevice: isPhysicalDevice,
      platform: platform,
      isDebugMode: isDebugMode,
      systemLocale: systemLocale,
    );
    return globalErrorReporting;
  }

  Future<void> reportError({
    required dynamic error,
    StackTrace? stackTrace,
    String? customMessage,
    Map<String, dynamic>? additionalInfo,
  }) async {
    try {
      final userId = await _localStorage.getCurrentUserId();
      final connectivity = await Connectivity().checkConnectivity();
      final deviceInfo = await DeviceInfoPlugin().deviceInfo;
      final now = DateTime.now();
      final timeZone = now.timeZoneOffset.toString();
      final deviceLocale = PlatformDispatcher.instance.locale.toString();
      
      final errorReport = {
        'error': error.toString(),
        'error_type': error.runtimeType.toString(),
        'trace': stackTrace?.toString() ?? 'No stack trace',
        'custom_message': customMessage,
        'additional_info': {
          ...?additionalInfo,
          if (userId != null) 'user_id': userId,
          // Базовая информация о приложении
          'platform': _platform,
          'app_name': _appName,
          'package_name': _packageName,
          'app_version': _appVersion,
          'build_number': _buildNumber,
          'is_debug_mode': _isDebugMode,
          
          // Информация об устройстве
          'device_model': _deviceModel,
          'os_version': _osVersion,
          'is_physical_device': _isPhysicalDevice,
          'device_info': deviceInfo.data,
          'system_locale': _systemLocale,
          'device_locale': deviceLocale,
          
          // Временная информация
          'timestamp': now.toIso8601String(),
          'timezone': timeZone,
          'local_time': now.toLocal().toString(),
          
          // Состояние приложения
          'memory_usage': ProcessInfo.currentRss,
          'free_memory': ProcessInfo.maxRss,
          'uptime': DateTime.now().difference(DateTime.fromMillisecondsSinceEpoch(0)).toString(),
          
          // Сетевая информация
          'connectivity_status': connectivity.toString(),
          'platform_brightness': PlatformDispatcher.instance.platformBrightness.toString(),
          
          // Системная информация
          'screen_size': '${PlatformDispatcher.instance.views.first.physicalSize}',
          'device_pixel_ratio': PlatformDispatcher.instance.views.first.devicePixelRatio,
          'text_scale_factor': PlatformDispatcher.instance.textScaleFactor,
          
          // Дополнительная информация о состоянии приложения
          'last_activity': await _localStorage.getLastActivityTimestamp(),
          'current_route': await _localStorage.getCurrentRoute(),
          'app_state': await _getAppState(),
          
          // Информация о предыдущих ошибках
          'error_count_last_hour': await _getErrorCountLastHour(),
          'last_error_timestamp': await _localStorage.getLastErrorTimestamp(),
          
          // Пользовательские настройки
          'user_preferences': await _getUserPreferences(),
        }
      };

      await _apiService.post('/v1/error_reports', data: errorReport);
      await _localStorage.setLastErrorTimestamp(now.toIso8601String());
      await _incrementErrorCount();

      _logger.i('Error reported successfully: ${error.toString()}');
    } catch (e, s) {
      _logger.e('Failed to report error', error: e, stackTrace: s);
    }
  }

  Future<Map<String, dynamic>> _getUserPreferences() async {
    try {
      return {
        'theme': (await _localStorage.getThemeState()).themeMode.toString(),
        'language': (await _localStorage.getLanguageState()).enumLang.toString(),
        'metric_selection': (await _localStorage.getMetricUserSelection()).toString(),
        'imperial_selection': (await _localStorage.getImperialUserSelection()).toString(),
      };
    } catch (e) {
      return {'error': 'Failed to get preferences'};
    }
  }

  Future<String> _getAppState() async {
    try {
      return {
        'core_selection': await _localStorage.getCoreUserSelection(),
        'metric_scroll_position': await _localStorage.getMetricScrollPosition(),
        'imperial_scroll_position': await _localStorage.getImperialScrollPosition(),
      }.toString();
    } catch (e) {
      return 'Failed to get app state';
    }
  }

  Future<int> _getErrorCountLastHour() async {
    try {
      final count = await _localStorage.getErrorCountLastHour() ?? 0;
      return count;
    } catch (e) {
      return -1;
    }
  }

  Future<void> _incrementErrorCount() async {
    try {
      final count = await _getErrorCountLastHour();
      await _localStorage.setErrorCountLastHour(count + 1);
    } catch (e) {
      _logger.e('Failed to increment error count', error: e);
    }
  }

  Future<void> reportFatalError({
    required dynamic error,
    StackTrace? stackTrace,
    bool shouldTerminateApp = true,
  }) async {
    try {
      await reportError(
        error: error,
        stackTrace: stackTrace,
        additionalInfo: {'is_fatal': true},
      );

      if (shouldTerminateApp) {
        // Здесь можно добавить логику закрытия приложения
        // Например, через SystemNavigator.pop() или другие механизмы
        // SystemNavigator.pop();
      }
    } catch (e) {
      _logger.e('Critical error during fatal error reporting', error: e);
    }
  }
}
