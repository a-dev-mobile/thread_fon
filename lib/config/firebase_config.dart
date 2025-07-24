import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:threadfon/config/env_config.dart';

class FirebaseConfig {
  static FirebaseOptions get androidOptions => FirebaseOptions(
    apiKey: EnvConfig.firebaseAndroidApiKey,
    appId: EnvConfig.firebaseAndroidAppId,
    messagingSenderId: EnvConfig.firebaseAndroidMessagingSenderId,
    projectId: EnvConfig.firebaseAndroidProjectId,
    storageBucket: EnvConfig.firebaseAndroidStorageBucket,
  );

  static FirebaseOptions get iosOptions => FirebaseOptions(
    apiKey: EnvConfig.firebaseIosApiKey,
    appId: EnvConfig.firebaseIosAppId,
    messagingSenderId: EnvConfig.firebaseIosMessagingSenderId,
    projectId: EnvConfig.firebaseIosProjectId,
    storageBucket: EnvConfig.firebaseIosStorageBucket,
    iosClientId: EnvConfig.firebaseIosClientId,
    iosBundleId: EnvConfig.firebaseIosBundleId,
  );

  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError('Web platform is not supported at this time');
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidOptions;
      case TargetPlatform.iOS:
        return iosOptions;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }
}
