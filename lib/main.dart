import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:threadfon/data/m_thread/m_thread_repository.dart';
import 'package:threadfon/modules/threads/view/m_thread/cubit/m_thread_cubit.dart';

import 'app/app.dart';
import 'app/services/local_storage_service.dart';
import 'core/constants/storage.dart';
import 'core/utils/file_copy.dart';
import 'threadfon_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Initialize Firebase.

  await LocalStorageServices.service.initialize();
// Elsewhere in your code
  // FirebaseCrashlytics.instance.crash();

  sqfliteFfiInit();
  await copyDb();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final pathDB = LocalStorageServices.service.getString(ConstStorage.keyPathDB);

  runApp(MultiRepositoryProvider(
    providers: [
      RepositoryProvider<MThreadRepository>(
        create: (context) => MThreadRepository(pathDB: pathDB),
      ),
    ],
    child: MultiBlocProvider(providers: [
      BlocProvider(
        create: (context) => MThreadCubit(),
      ),
    ], child: const App()),
  ));
}

//
//
//
//
//
//
//
//
//
//
//

Future<void> copyDb() async {
  final pref = LocalStorageServices.service;

  final pathDB = pref.getString(ConstStorage.keyPathDB);
  if (pathDB.isNotEmpty) return;
  final patchTo = (await getApplicationSupportDirectory()).path;

  const nameFile = 'thread.db';
  const pathFrom = 'assets/db/';

  await FileCopy.fileCopyToMobileLocal(
    pathFrom: pathFrom,
    pathTo: patchTo,
    nameFile: nameFile,
  );
  await pref.saveString(ConstStorage.keyPathDB, '$patchTo/$nameFile');
}
