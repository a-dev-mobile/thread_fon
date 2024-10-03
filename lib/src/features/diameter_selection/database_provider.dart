// database_provider.dart
import 'package:flutter/material.dart';
import 'package:threadfon/src/features/diameter_selection/database_service.dart';

class DatabaseProvider extends InheritedWidget {
  const DatabaseProvider({
    required super.child,
    required this.databaseService,
    super.key,
  });
  final DatabaseService databaseService;

  /// Метод для доступа к DatabaseService из контекста
  static DatabaseService of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<DatabaseProvider>();
    if (provider == null) {
      throw FlutterError('DatabaseProvider not found in context');
    }
    return provider.databaseService;
  }

  // Обновлять виджеты, если экземпляр DatabaseService изменился
  @override
  bool updateShouldNotify(DatabaseProvider oldWidget) => false;
}
