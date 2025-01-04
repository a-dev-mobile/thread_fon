import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';

class DeviceIdGenerator {
  static Future<String> generateUniqueDeviceId() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String uniqueId = '';

    try {
      if (Platform.isAndroid) {
        final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        uniqueId = _generateHash('${androidInfo.id}'
            '${androidInfo.id}'
            '${androidInfo.manufacturer}'
            '${androidInfo.model}');
      } else if (Platform.isIOS) {
        final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        uniqueId = _generateHash('${iosInfo.identifierForVendor}'
            '${iosInfo.name}'
            '${iosInfo.systemName}'
            '${iosInfo.model}');
      } else if (kIsWeb) {
        // For web, use a combination of browser and system details
        final WebBrowserInfo webInfo = await deviceInfo.webBrowserInfo;
        uniqueId = _generateHash('${webInfo.userAgent}'
            '${webInfo.platform}'
            '${webInfo.browserName}');
      } else {
        uniqueId = 'UnknownPlatform';
      }
    } catch (e) {
      // Fallback to a random generated ID if device info can't be retrieved
      uniqueId = _generateHash(DateTime.now().toString());
    }

    return uniqueId;
  }

  /// Generate a consistent hash from input string
  static String _generateHash(String input) {
    // Use SHA-256 to create a consistent, unique hash
    final Uint8List bytes = utf8.encode(input);
    final Digest digest = sha256.convert(bytes);
    return digest.toString().substring(0, 32); // Truncate to 32 characters
  }

  /// Optional: Method to verify uniqueness and regenerate if needed
  static Future<String> getVerifiedUniqueDeviceId() async {
    // You could add additional checks or caching logic here
    return await generateUniqueDeviceId();
  }
}
