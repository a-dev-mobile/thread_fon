import 'package:flutter/material.dart';
import 'api_service.dart';

class ApiProvider extends InheritedWidget {
  final ApiService apiService;

  const ApiProvider({
    super.key,
    required this.apiService,
    required super.child,
  });

  // Метод для доступа к ApiService из контекста
  static ApiService of(BuildContext context) {
    final ApiProvider? provider = context.dependOnInheritedWidgetOfExactType<ApiProvider>();
    if (provider == null) {
      throw FlutterError('ApiProvider не найден в дереве виджетов');
    }
    return provider.apiService;
  }

  @override
  bool updateShouldNotify(covariant ApiProvider oldWidget) {
    // Обновляем только если экземпляр ApiService изменился
    return apiService != oldWidget.apiService;
  }
}
