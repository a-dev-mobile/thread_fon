import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:threadfon/app/app.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/app_bloc_observer.dart';
// Импорт LogBatcher
import 'package:threadfon/core/services/logging/log_batcher.dart';
import 'package:threadfon/core/services/logging/logger.dart';

final _logger = LogService('main');

Future<void> main() async {
  // Обернуть всё в runZonedGuarded, включая инициализацию Flutter bindings
  runZonedGuarded<void>(
    () async {
      // Инициализация Flutter и сохранение splash-экрана внутри зоны
      var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Инициализация LogBatcher (singleton)
      LogBatcher();

      try {
        // Инициализация локального хранилища
        final localStorage = LocalStorage(isShowLog: true);
        await localStorage.initialize();

        // Настройка глобального обработчика ошибок Flutter
        FlutterError.onError = (details) {
          if (!kReleaseMode) {
            // В режиме разработки выводим ошибку в консоль
            FlutterError.dumpErrorToConsole(details);
          }

          // Log the error
          _logger.e('FlutterError.onError', error: details.exception, stackTrace: details.stack ?? StackTrace.current);
        };

        // Установка предпочтительной ориентации экрана
        // await SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        //   DeviceOrientation.portraitDown,
        // ]);
        var languageState = await localStorage.getLanguageState();
        var themeState = await localStorage.getThemeState();
        // Запуск приложения с провайдерами
        Bloc.observer = const AppBlocObserver();
        runApp(
          MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(
                value: localStorage,
              ),
              RepositoryProvider(
                create: (context) => ApiService(),
              ),
            ],
            child: MyApp(
              enumLang: languageState.enumLang,
              themeMode: themeState.themeMode,
            ),
          ),
        );
      } on Exception catch (e, s) {
        // Log exceptions from the try-catch block
        _logger.e('Exception in main', error: e, stackTrace: s);
      } finally {
        // Удаление splash-экрана и логирование закрытия
        FlutterNativeSplash.remove();
        _logger.t('** close NATIVE splash**', includeStackTrace: false);
      }

      // Обработка всех необработанных асинхронных ошибок
      PlatformDispatcher.instance.onError = (error, stack) {
        // Log the error
        _logger.e('🚑 PlatformDispatcher.onError', error: error, stackTrace: stack);
        return true;
      };

      // Handle errors from isolates
      Isolate.current.addErrorListener(
        RawReceivePort((List<dynamic> errorAndStacktrace) {
          final error = errorAndStacktrace.first;
          final stackTrace = errorAndStacktrace.last as StackTrace;

          _logger.e('Isolate error', error: error, stackTrace: stackTrace);
        }).sendPort,
      );

      // Добавляем наблюдателя за жизненным циклом приложения для вызова dispose()
      WidgetsBinding.instance.addObserver(_AppLifecycleObserver());
    },
    (error, stack) {
      // Log errors from runZonedGuarded
      _logger.e('runZonedGuarded', error: error, stackTrace: stack);
    },
  );
}

// Класс для отслеживания жизненного цикла приложения
class _AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached || state == AppLifecycleState.inactive) {
      // Call dispose() when the app is closing
      LogBatcher().dispose();
    }
  }
}
