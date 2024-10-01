import 'dart:io';

import 'package:flutter/services.dart';

import 'package:threadfon/src/common/util/app_log.dart';

/// Exception thrown when copying fails
// class DbNotCopy implements Exception {}

class FileCopy {
  static Future<void> fileCopyToMobileLocal({
    required String pathFrom,
    required String pathTo,
    required String nameFile,
  }) async {
    log.i('start copy file $nameFile');
    try {
      final data = await rootBundle.load('$pathFrom$nameFile');
      final fullPath = '$pathTo/$nameFile';
      final buffer = data.buffer;
      await File(fullPath).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      );
    } catch (e) {
      log.e(e);
    }

    log.i('end copy  file $nameFile');
  }
}
