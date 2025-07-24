import 'dart:async';
import 'dart:isolate';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Добавлен импорт Crashlytics
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:nested/nested.dart';
import 'package:threadfon/app/app.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/router/app_router.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/config/firebase_config.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/app_bloc_observer.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/restart_widget.dart';

final LogService _logger = LogService('main');

// Создание глобального экземпляра FirebaseAnalytics
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

Future<void> main() async {
  // Обернуть всё в runZonedGuarded, включая инициализацию Flutter bindings
  runZonedGuarded<void>(
    () async {
      // Инициализация Flutter и сохранение splash-экрана внутри зоны
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      try {
        await Firebase.initializeApp(options: FirebaseConfig.currentPlatform);

        // Инициализация Crashlytics
        // Включаем сбор нефатальных ошибок
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(
          !kDebugMode,
        );

        // Передаём все необработанные асинхронные ошибки в Crashlytics
        PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };

        // Инициализация локального хранилища
        final LocalStorage localStorage = LocalStorage(isShowLog: true);
        await localStorage.initialize();
        final String _ = await localStorage.ensureUserId();

        final ApiService apiService = await ApiService().init();
        // Настройка глобального обработчика ошибок Flutter (сохранение существующей логики)
        FlutterError.onError = (FlutterErrorDetails details) {
          if (!kReleaseMode) {
            // В режиме разработки выводим ошибку в консоль
            FlutterError.dumpErrorToConsole(details);
          }

          _logger.e(
            'FlutterError.onError',
            error: details.exception,
            stackTrace: details.stack ?? StackTrace.current,
            reportToServer: false,
          );

          // Также отправляем в Crashlytics
          FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        };

        // Установка предпочтительной ориентации экрана
        // await SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        //   DeviceOrientation.portraitDown,
        // ]);

        LanguageState languageState = await localStorage.getLanguageState();
        ThemeState themeState = await localStorage.getThemeState();

        // Запуск приложения с провайдерами
        Bloc.observer = const AppBlocObserver();
        runApp(
          RestartWidget(
            child: MultiRepositoryProvider(
              providers: <SingleChildWidget>[
                RepositoryProvider<LocalStorage>.value(value: localStorage),
                RepositoryProvider<ApiService>.value(value: apiService),
                RepositoryProvider<AppRouter>(
                  create: (BuildContext context) =>
                      AppRouter(analytics: analytics),
                ),
              ],
              child: App(
                enumLang: languageState.enumLang,
                themeMode: themeState.themeMode,
              ),
            ),
          ),
        );
      } on Exception catch (e, s) {
        // Логируем и отправляем критические ошибки
        _logger.e('Exception in main', error: e, stackTrace: s);

        // Отправляем исключение в Crashlytics
        await FirebaseCrashlytics.instance.recordError(e, s, fatal: true);
      } finally {
        // Удаление splash-экрана и логирование закрытия
        FlutterNativeSplash.remove();
        _logger.t('** close NATIVE splash**', includeStackTrace: false);
      }

      // Обработка всех необработанных асинхронных ошибок (уже настроено выше для Crashlytics)
      // Поскольку мы уже установили PlatformDispatcher.instance.onError выше, этот блок можно удалить или оставить для дополнительной логики

      // Обработка ошибок из изолятов
      Isolate.current.addErrorListener(
        RawReceivePort((List<dynamic> errorAndStacktrace) {
          final e = errorAndStacktrace.first;
          final StackTrace s = errorAndStacktrace.last as StackTrace;

          _logger.e('Isolate error', error: e, stackTrace: s);

          // Отправляем ошибку в Crashlytics
          FirebaseCrashlytics.instance.recordError(e, s, fatal: true);
        }).sendPort,
      );

      // Добавляем наблюдателя за жизненным циклом приложения для вызова dispose()
      WidgetsBinding.instance.addObserver(_AppLifecycleObserver());
    },
    (Object e, StackTrace s) {
      // Логируем ошибки из runZonedGuarded
      _logger.e('runZonedGuarded', error: e, stackTrace: s);

      // Отправляем ошибку в Crashlytics
      FirebaseCrashlytics.instance.recordError(e, s, fatal: true);
    },
  );
}

// Класс для отслеживания жизненного цикла приложения
class _AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      // Вызов dispose() при закрытии приложения, если необходимо
    }
  }
}
