import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path_provider/path_provider.dart';

import 'package:threadfon/src/common/app/app.dart';
import 'package:threadfon/src/common/data/local_storage.dart';
import 'package:threadfon/src/common/data/local_storage_provider.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/common/services/api_provider.dart';
import 'package:threadfon/src/common/services/api_service.dart';
import 'package:threadfon/src/common/util/file_copy.dart';
// Импорт DatabaseProvider

final _l = L('main');

Future<void> main() async {
  // Обернуть всё в runZonedGuarded, включая инициализацию Flutter bindings
  runZonedGuarded<void>(
    () async {
      // Инициализация Flutter и сохранение splash-экрана внутри зоны
      var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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

          if (kReleaseMode) {
            // В релизном режиме отправляем все ошибки в Firebase
            AppErrorHandler().recordError(exception, stackTrace);
          } else {
            // В режиме разработки логируем ошибку для отладки
            _l.e('FlutterError.onError', error: exception, stackTrace: stackTrace);
          }
        };

        // Установка предпочтительной ориентации экрана
        // await SystemChrome.setPreferredOrientations([
        //   DeviceOrientation.portraitUp,
        //   DeviceOrientation.portraitDown,
        // ]);

/* 
DB_USER="postgres"
export PGPASSWORD="v5dIY8UaX28kpkf6o6ZhoTAPYT6MYcaKxRh9Zg7dwZQfNEXI8c"
DB_HOST="134.255.232.136"


DB_NAME="dev_thread_db"

# Переменные для подключения к базе данных
DB_USER="postgres"
export PGPASSWORD="v5dIY8UaX28kpkf6o6ZhoTAPYT6MYcaKxRh9Zg7dwZQfNEXI8c"
DB_HOST="134.255.232.136"
DB_PORT="5432"
          host: '134.255.232.136',
          database: 'dev_thread_db',
          username: 'postgres',
          password: 'v5dIY8UaX28kpkf6o6ZhoTAPYT6MYcaKxRh9Zg7dwZQfNEXI8c',
 */
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
        // Логирование ошибок из блока try-catch с указанием источника
        if (kReleaseMode) {
          // В релизном режиме отправляем ошибку в Firebase с полным стеком вызовов
          await AppErrorHandler().recordError(e, s);
        } else {
          // В режиме разработки логируем ошибку с полным стеком вызовов
          _l.e('Exception in main', error: e, stackTrace: s);
        }
      } finally {
        // Удаление splash-экрана и логирование закрытия
        FlutterNativeSplash.remove();
        _l.t('** close NATIVE splash**', includeStackTrace: false);
      }

      // Обработка всех необработанных асинхронных ошибок
      PlatformDispatcher.instance.onError = (error, stack) {
        if (kReleaseMode) {
          // В релизном режиме отправляем ошибку в Firebase
          AppErrorHandler().recordError(error, stack);
        } else {
          // В режиме разработки логируем ошибку для отладки
          _l.e('🚑 PlatformDispatcher.onError', error: error, stackTrace: stack);
        }

        return true;
      };

      if (kReleaseMode) {
        // Обработка ошибок из изолятов только в релизном режиме
        Isolate.current.addErrorListener(
          RawReceivePort((List<dynamic> errorAndStacktrace) async {
            final error = errorAndStacktrace.first;
            final stackTrace = errorAndStacktrace.last as StackTrace;

            // Отправляем ошибку в Firebase
            await AppErrorHandler().recordError(error, stackTrace);
          }).sendPort,
        );
      } else {
        // Логирование ошибок из изолятов в режиме разработки
        Isolate.current.addErrorListener(
          RawReceivePort((List<dynamic> errorAndStacktrace) {
            final error = errorAndStacktrace.first;
            final stackTrace = errorAndStacktrace.last as StackTrace;

            _l.e('Isolate Error: $error', stackTrace: stackTrace);
          }).sendPort,
        );
      }
    },
    (error, stack) {
      // Логирование ошибок из runZonedGuarded с указанием источника
      if (kReleaseMode) {
        // В релизном режиме отправляем ошибку в Firebase
        AppErrorHandler().recordError(error, stack);
      } else {
        // В режиме разработки логируем ошибку для отладки
        _l.e('runZonedGuarded', error: error, stackTrace: stack);
      }
    },
  );
}

/// Копирование базы данных, если она ещё не скопирована
Future<void> copyDb(LocalStorage localStorage) async {
  final pathDB = await localStorage.getPathDB();

  if (pathDB.isNotEmpty) return;

  final pathTo = (await getApplicationSupportDirectory()).path;
  const nameFile = 'thread.db';
  const pathFrom = 'assets/db/';

  await FileCopy.fileCopyToMobileLocal(
    pathFrom: pathFrom,
    pathTo: pathTo,
    nameFile: nameFile,
  );

  await localStorage.setPathDB('$pathTo/$nameFile');
}
