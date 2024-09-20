import 'dart:io';

import 'package:flutter/foundation.dart';

String get bannerAdUnitId {
  if (Platform.isAndroid) {
    return kReleaseMode
        ? 'ca-app-pub-6155876762943258/1259389000'
        : 'ca-app-pub-3940256099942544/6300978111'; //test
  } else if (Platform.isIOS) {
    return kReleaseMode
        ? 'ca-app-pub-6155876762943258/2024732843'
        : 'ca-app-pub-3940256099942544/2934735716'; //test
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}

String get interstitialAdUnitId {
  if (Platform.isAndroid) {
    return kReleaseMode
        ? 'ca-app-pub-6155876762943258/6320143991'
        : 'ca-app-pub-3940256099942544/1033173712'; //test
  } else if (Platform.isIOS) {
    return kReleaseMode
        ? 'ca-app-pub-6155876762943258/1634167835'
        : 'ca-app-pub-3940256099942544/4411468910'; //test
  } else {
    throw UnsupportedError('Unsupported platform');
  }
}
