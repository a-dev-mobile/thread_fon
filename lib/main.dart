import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';


import 'package:threadfon/app/app.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/local_storage/local_storage_provider.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/services/api_service/api_provider.dart';
import 'package:threadfon/core/services/api_service/api_service.dart';

// Импорт LogBatcher
import 'package:threadfon/core/services/logging/log_batcher.dart';

final _l = L('main');

Future<void> main() async {
  // Обернуть всё в runZonedGuarded, включая инициализацию Flutter bindings
  runZonedGuarded<void>(
    () async {
      // Инициализация Flutter и сохранение splash-экрана внутри зоны
      var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Инициализируем LogBatcher (необязательно, так как это singleton, но можно для явности)
      final logBatcher = LogBatcher();

      try {
        // Инициализация локального хранилища
        final localStorage = LocalStorage(isShowLog: true);
        await localStorage.initialize();

        // Настройка глобального обработчика ошибок Flutter
        FlutterError.onError = (details) {
          final exception = details.exception;
          final stackTrace = details.stack ?? StackTrace.current;

          if (!kReleaseMode) {
            // В режиме разработки выводим ошибку в консоль
            FlutterError.dumpErrorToConsole(details);
          }

          // Log the error
          _l.e('FlutterError.onError', error: exception, stackTrace: stackTrace);
        };

        // Установка предпочтительной ориентации экрана
        // await SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        //   DeviceOrientation.portraitDown,
        // ]);

        // Запуск приложения с провайдерами
        runApp(
          ApiProvider(
            apiService: ApiService(),
            child: LocalStorageProvider(
              localStorage: localStorage,
              child: const App(),
            ),
          ),
        );
      } on Exception catch (e, s) {
        // Log exceptions from the try-catch block
        _l.e('Exception in main', error: e, stackTrace: s);
      } finally {
        // Удаление splash-экрана и логирование закрытия
        FlutterNativeSplash.remove();
        _l.t('** close NATIVE splash**', includeStackTrace: false);
      }

      // Обработка всех необработанных асинхронных ошибок
      PlatformDispatcher.instance.onError = (error, stack) {
        // Log the error
        _l.e('🚑 PlatformDispatcher.onError', error: error, stackTrace: stack);
        return true;
      };

      // Handle errors from isolates
      Isolate.current.addErrorListener(
        RawReceivePort((List<dynamic> errorAndStacktrace) {
          final error = errorAndStacktrace.first;
          final stackTrace = errorAndStacktrace.last as StackTrace;

          _l.e('Isolate Error: $error', stackTrace: stackTrace);
        }).sendPort,
      );

      // Добавляем наблюдателя за жизненным циклом приложения для вызова dispose()
      WidgetsBinding.instance.addObserver(_AppLifecycleObserver());
    },
    (error, stack) {
      // Log errors from runZonedGuarded
      _l.e('runZonedGuarded', error: error, stackTrace: stack);
    },
  );
}

// Класс для отслеживания жизненного цикла приложения
class _AppLifecycleObserver extends WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached ||
        state == AppLifecycleState.inactive) {
      // Call dispose() when the app is closing
      LogBatcher().dispose();
    }
  }
}
