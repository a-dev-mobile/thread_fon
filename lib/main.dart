import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Добавлен импорт Crashlytics
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:threadfon/app/app.dart';
import 'package:threadfon/app/router/router.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/app_bloc_observer.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/restart_widget.dart';
import 'package:threadfon/firebase_options.dart';

final _logger = LogService('main');

// Создание глобального экземпляра FirebaseAnalytics
final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

Future<void> main() async {
  // Обернуть всё в runZonedGuarded, включая инициализацию Flutter bindings
  runZonedGuarded<void>(
    () async {
      // Инициализация Flutter и сохранение splash-экрана внутри зоны
      var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      try {
        await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        );

        // Инициализация Crashlytics
        // Включаем сбор нефатальных ошибок
        await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(!kDebugMode);

        // Передаём все необработанные асинхронные ошибки в Crashlytics
        PlatformDispatcher.instance.onError = (error, stack) {
          FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
          return true;
        };

        // Инициализация локального хранилища
        final localStorage = LocalStorage(isShowLog: true);
        await localStorage.initialize();

        // Настройка глобального обработчика ошибок Flutter (сохранение существующей логики)
        FlutterError.onError = (details) {
          if (!kReleaseMode) {
            // В режиме разработки выводим ошибку в консоль
            FlutterError.dumpErrorToConsole(details);
          }

          // Логируем ошибку
          _logger.e('FlutterError.onError', error: details.exception, stackTrace: details.stack ?? StackTrace.current);

          // Также отправляем в Crashlytics
          FirebaseCrashlytics.instance.recordFlutterFatalError(details);
        };

        // Установка предпочтительной ориентации экрана
        // await SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        //   DeviceOrientation.portraitDown,
        // ]);

        var languageState = await localStorage.getLanguageState();
        var themeState = await localStorage.getThemeState();

        final apiService = await ApiService().init();

        // Запуск приложения с провайдерами
        Bloc.observer = const AppBlocObserver();
        runApp(
          RestartWidget(
            child: MultiRepositoryProvider(
              providers: [
                RepositoryProvider.value(
                  value: localStorage,
                ),
                RepositoryProvider.value(
                  value: apiService,
                ),
                RepositoryProvider(
                  create: (context) => AppRouter(analytics: analytics),
                ),
              ],
              child: MyApp(
                enumLang: languageState.enumLang,
                themeMode: themeState.themeMode,
              ),
            ),
          ),
        );
      } on Exception catch (e, s) {
        // Логируем исключения из блока try-catch
        _logger.e('Exception in main', error: e, stackTrace: s);

        // Отправляем исключение в Crashlytics
        FirebaseCrashlytics.instance.recordError(e, s, fatal: true);
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
          final error = errorAndStacktrace.first;
          final stackTrace = errorAndStacktrace.last as StackTrace;

          _logger.e('Isolate error', error: error, stackTrace: stackTrace);

          // Отправляем ошибку в Crashlytics
          FirebaseCrashlytics.instance.recordError(error, stackTrace, fatal: true);
        }).sendPort,
      );

      // Добавляем наблюдателя за жизненным циклом приложения для вызова dispose()
      WidgetsBinding.instance.addObserver(_AppLifecycleObserver());
    },
    (error, stack) {
      // Логируем ошибки из runZonedGuarded
      _logger.e('runZonedGuarded', error: error, stackTrace: stack);

      // Отправляем ошибку в Crashlytics
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    },
  );
}

// Класс для отслеживания жизненного цикла приложения
class _AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached || state == AppLifecycleState.inactive) {
      // Вызов dispose() при закрытии приложения, если необходимо
    }
  }
}
