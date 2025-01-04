// lib/core/services/api_service/user_agent_provider.dart
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/widgets.dart' show WidgetsBinding;
import 'package:package_info_plus/package_info_plus.dart';

Future<String> getUserAgent() async {
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  const String appName = 'ThreadFon';
  final String version = packageInfo.version;
  final String buildNumber = packageInfo.buildNumber;

  String platformName;
  if (defaultTargetPlatform == TargetPlatform.android) {
    platformName = 'Android';
  } else if (defaultTargetPlatform == TargetPlatform.iOS) {
    platformName = 'iOS';
  } else if (defaultTargetPlatform == TargetPlatform.linux) {
    platformName = 'Linux';
  } else if (defaultTargetPlatform == TargetPlatform.macOS) {
    platformName = 'macOS';
  } else if (defaultTargetPlatform == TargetPlatform.windows) {
    platformName = 'Windows';
  } else {
    platformName = 'Unknown';
  }

  final String osVersion = Platform.operatingSystemVersion;
  final String locale = WidgetsBinding.instance.window.locale.toString();
  final String timeZone = DateTime.now().timeZoneName;

  // Формируем User-Agent строку
  return '$appName/$version/$buildNumber (Platform=Flutter;OS=$platformName $osVersion;Locale=$locale;TimeZone=$timeZone)';
}
