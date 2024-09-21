import 'dart:async';
import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:threadfon/app/app.dart';
import 'package:threadfon/app/services/local_storage_service.dart';
import 'package:threadfon/app_error_handler.dart';
import 'package:threadfon/core/constants/storage.dart';
import 'package:threadfon/core/utils/file_copy.dart';
import 'package:threadfon/data/m_thread/m_thread_repository.dart';
import 'package:threadfon/modules/threads/view/m_thread/cubit/m_thread_cubit.dart';
import 'package:threadfon/src/common/log/l_setup.dart';
import 'package:threadfon/src/common/util/error_util.dart';

final _l = L('main');

Future<void> main() async {
  // Обернуть всё в runZonedGuarded, включая инициализацию Flutter bindings
  runZonedGuarded<void>(
    () async {
      // Инициализация Flutter и сохранение splash-экрана внутри зоны
      WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      try {
        // Инициализация локального хранилища
        await LocalStorageServices.service.initialize();

        // Настройка глобального обработчика ошибок Flutter
        FlutterError.onError = (FlutterErrorDetails details) {
          final exception = details.exception;
          final stackTrace = details.stack ?? StackTrace.current;

          if (!kReleaseMode) {
            // В режиме разработки выводим ошибку в консоль
            FlutterError.dumpErrorToConsole(details);
          }

          // Форматируем стек вызовов для лучшей читаемости
 

          if (kReleaseMode) {
            // В релизном режиме отправляем все ошибки в Firebase
            AppErrorHandler.recordError(exception, stackTrace);
          } else {
            // В режиме разработки логируем ошибку для отладки
            _l.e('FlutterError.onError', error: exception, stackTrace: stackTrace);
          }
        };

        // Инициализация sqflite FFI и копирование базы данных
        sqfliteFfiInit();
        await copyDb();

        // Установка предпочтительной ориентации экрана
        await SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);

        final pathDB = LocalStorageServices.service.getString(ConstStorage.keyPathDB);

        // Запуск приложения с провайдерами репозиториев и BLoC
        runApp(
          MultiRepositoryProvider(
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
        );
      } catch (e, s) {
        // Логирование ошибок из блока try-catch с указанием источника
        if (kReleaseMode) {
          // В релизном режиме отправляем ошибку в Firebase с полным стеком вызовов
          AppErrorHandler.recordError(e, s);
        } else {
          // В режиме разработки логируем ошибку с полным стеком вызовов
          _l.e('Exception in main', error: e, stackTrace: s);
        }
      } finally {
        // Удаление splash-экрана и логирование закрытия
        FlutterNativeSplash.remove();
        _l.vNoStack('** close NATIVE splash**');
      }

      // Обработка всех необработанных асинхронных ошибок
      PlatformDispatcher.instance.onError = (error, stack) {
        if (kReleaseMode) {
          // В релизном режиме отправляем ошибку в Firebase
          AppErrorHandler.recordError(error, stack);
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
            await AppErrorHandler.recordError(error, stackTrace);
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
        AppErrorHandler.recordError(error, stack);
      } else {
        // В режиме разработки логируем ошибку для отладки
        _l.e('runZonedGuarded', error: error, stackTrace: stack);
      }
    },
  );
}

/// Копирование базы данных, если она ещё не скопирована
Future<void> copyDb() async {
  final pref = LocalStorageServices.service;
  final pathDB = pref.getString(ConstStorage.keyPathDB);

  if (pathDB.isNotEmpty) return;

  final pathTo = (await getApplicationSupportDirectory()).path;
  const nameFile = 'thread.db';
  const pathFrom = 'assets/db/';

  await FileCopy.fileCopyToMobileLocal(
    pathFrom: pathFrom,
    pathTo: pathTo,
    nameFile: nameFile,
  );

  await pref.saveString(ConstStorage.keyPathDB, '$pathTo/$nameFile');
}
