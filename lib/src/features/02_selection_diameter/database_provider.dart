// // database_provider.dart
// import 'package:flutter/material.dart';
// import 'package:threadfon/src/features/02_selection_diameter/database_service.dart';

// class DatabaseProvider extends InheritedWidget {
//   const DatabaseProvider({
//     required super.child,
//     required this.apiService,
//     super.key,
//   });
//   final ApiService apiService;

//   /// Метод для доступа к ApiService из контекста
//   static ApiService of(BuildContext context) {
//     final provider =
//         context.dependOnInheritedWidgetOfExactType<DatabaseProvider>();
//     if (provider == null) {
//       throw FlutterError('DatabaseProvider not found in context');
//     }
//     return provider.apiService;
//   }

//   // Обновлять виджеты, если экземпляр ApiService изменился
//   @override
//   bool updateShouldNotify(DatabaseProvider oldWidget) => false;
// }
