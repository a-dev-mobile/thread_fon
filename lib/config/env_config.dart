class EnvConfig {
  // API URLs
  static String get apiPrimaryUrl =>
      const String.fromEnvironment('API_PRIMARY_URL');
  static String get apiFallbackUrl =>
      const String.fromEnvironment('API_FALLBACK_URL');

  // Firebase Android config
  static String get firebaseAndroidApiKey =>
      const String.fromEnvironment('FIREBASE_ANDROID_API_KEY');
  static String get firebaseAndroidAppId =>
      const String.fromEnvironment('FIREBASE_ANDROID_APP_ID');
  static String get firebaseAndroidMessagingSenderId =>
      const String.fromEnvironment('FIREBASE_ANDROID_MESSAGING_SENDER_ID');
  static String get firebaseAndroidProjectId =>
      const String.fromEnvironment('FIREBASE_ANDROID_PROJECT_ID');
  static String get firebaseAndroidStorageBucket =>
      const String.fromEnvironment('FIREBASE_ANDROID_STORAGE_BUCKET');

  // Firebase iOS config
  static String get firebaseIosApiKey =>
      const String.fromEnvironment('FIREBASE_IOS_API_KEY');
  static String get firebaseIosAppId =>
      const String.fromEnvironment('FIREBASE_IOS_APP_ID');
  static String get firebaseIosMessagingSenderId =>
      const String.fromEnvironment('FIREBASE_IOS_MESSAGING_SENDER_ID');
  static String get firebaseIosProjectId =>
      const String.fromEnvironment('FIREBASE_IOS_PROJECT_ID');
  static String get firebaseIosStorageBucket =>
      const String.fromEnvironment('FIREBASE_IOS_STORAGE_BUCKET');
  static String get firebaseIosClientId =>
      const String.fromEnvironment('FIREBASE_IOS_CLIENT_ID');
  static String get firebaseIosBundleId =>
      const String.fromEnvironment('FIREBASE_IOS_BUNDLE_ID');

  static String get iosAppStoreUrl =>
      const String.fromEnvironment('IOS_APPSTORE_URL');

  static String get androidGooglePlayUrl =>
      const String.fromEnvironment('ANDROID_GOOGLEPLAY_URL');

  static String get email => const String.fromEnvironment('EMAIL');
}
