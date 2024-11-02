// app_text_styles_extension.dart

import 'package:flutter/material.dart';

/// Расширение на [BuildContext], добавляющее доступ к [AppTextStyles].
extension AppTextStylesExtension on BuildContext {
  /// Геттер для получения объекта [AppTextStyles], содержащего все стили текста.
  AppTextStyles get textStyle => AppTextStyles(this);
}

/// Класс, содержащий все стили текста, получаемые из [TextTheme].
/// Этот класс используется только внутри расширения [AppTextStylesExtension].
class AppTextStyles {
  AppTextStyles(this.context);
  final BuildContext context;

  /// Использует [displayLarge] из [TextTheme].
  TextStyle get displayLarge => Theme.of(context).textTheme.displayLarge!;

  /// Использует [displayMedium] из [TextTheme].
  TextStyle get displayMedium => Theme.of(context).textTheme.displayMedium!;

  /// Использует [displaySmall] из [TextTheme].
  TextStyle get displaySmall => Theme.of(context).textTheme.displaySmall!;

  /// Использует [headlineLarge] из [TextTheme].
  TextStyle get headlineLarge => Theme.of(context).textTheme.headlineLarge!;

  /// Использует [headlineMedium] из [TextTheme].
  TextStyle get headlineMedium => Theme.of(context).textTheme.headlineMedium!;

  /// Использует [headlineSmall] из [TextTheme].
  TextStyle get headlineSmall => Theme.of(context).textTheme.headlineSmall!;

  /// Использует [titleLarge] из [TextTheme].
  TextStyle get titleLarge => Theme.of(context).textTheme.titleLarge!;

  /// Использует [titleMedium] из [TextTheme].
  TextStyle get titleMedium => Theme.of(context).textTheme.titleMedium!;

  /// Использует [titleSmall] из [TextTheme].
  TextStyle get titleSmall => Theme.of(context).textTheme.titleSmall!;

  /// Использует [bodyLarge] из [TextTheme].
  TextStyle get bodyLarge => Theme.of(context).textTheme.bodyLarge!;

  /// Использует [bodyMedium] из [TextTheme].
  TextStyle get bodyMedium => Theme.of(context).textTheme.bodyMedium!;

  /// Использует [bodySmall] из [TextTheme].
  TextStyle get bodySmall => Theme.of(context).textTheme.bodySmall!;

  /// Использует [labelLarge] из [TextTheme].
  TextStyle get labelLarge => Theme.of(context).textTheme.labelLarge!;

  /// Использует [labelMedium] из [TextTheme].
  TextStyle get labelMedium => Theme.of(context).textTheme.labelMedium!;

  /// Использует [labelSmall] из [TextTheme].
  TextStyle get labelSmall => Theme.of(context).textTheme.labelSmall!;
}
