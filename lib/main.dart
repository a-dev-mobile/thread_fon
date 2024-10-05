import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:threadfon/src/common/app/app.dart';
import 'package:threadfon/src/common/data/local_storage.dart';
import 'package:threadfon/src/common/data/local_storage_provider.dart';
import 'package:threadfon/src/common/data/m_thread_repository.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/common/util/file_copy.dart';
import 'package:threadfon/src/features/diameter_selection/database_provider.dart'; // Импорт DatabaseProvider
import 'package:threadfon/src/features/diameter_selection/database_service.dart'; // Импорт DatabaseService
import 'package:threadfon/src/features/threads/view/m_thread/cubit/m_thread_cubit.dart';

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

        // Инициализация sqflite FFI и копирование базы данных
        sqfliteFfiInit();
        await copyDb(localStorage);

        // Установка предпочтительной ориентации экрана
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        final pathDB = await localStorage.getPathDB();

        // Инициализация DatabaseService
        final databaseService = DatabaseService(
          host: '134.255.232.136',
          database: 'thread_db',
          username: 'readonly_user',
          password: '123123',
        );

        // Запуск приложения с провайдерами
        runApp(
          DatabaseProvider(
            databaseService: databaseService,
            child: LocalStorageProvider(
              localStorage: localStorage,
              child: MultiRepositoryProvider(
                providers: [
                  RepositoryProvider<MThreadRepository>(
                    create: (context) => MThreadRepository(pathDB: pathDB),
                  ),
                ],
                child: MultiBlocProvider(
                  providers: [
                    BlocProvider(
                      create: (context) => MThreadCubit(),
                    ),
                  ],
                  child: const App(),
                ),
              ),
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
