// Package imports:
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'app/app.dart';
import 'app/services/local_storage_service.dart';
import 'core/constants/storage.dart';
import 'core/utils/file_copy.dart';
import 'threadfon_bloc_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
// Initialize Firebase.
  await Firebase.initializeApp();
  await LocalStorageServices.service.initialize();
// Elsewhere in your code
  // FirebaseCrashlytics.instance.crash();

  await MobileAds.instance.initialize();
  sqfliteFfiInit();
  await copyDb();

  final hydratedStorage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  HydratedBlocOverrides.runZoned(
    () => runApp(const App()),
    storage: hydratedStorage,
    blocObserver: ThreadFonBlocObserver(),
  );
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
