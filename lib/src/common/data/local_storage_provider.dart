import 'package:flutter/material.dart';
import 'package:threadfon/src/common/data/local_storage.dart';

class LocalStorageProvider extends InheritedWidget {
  const LocalStorageProvider({
    required this.localStorage,
    required super.child,
    super.key,
  });

  final LocalStorage localStorage;

  static LocalStorage of(BuildContext context) {
    final result = context.dependOnInheritedWidgetOfExactType<LocalStorageProvider>();
    assert(result != null, 'No LocalStorageProvider found in context');
    return result!.localStorage;
  }

  @override
  bool updateShouldNotify(covariant LocalStorageProvider oldWidget) => localStorage != oldWidget.localStorage;
}
