// lib/core/widgets/base_screen.dart

import 'package:flutter/material.dart';
import 'package:threadfon/features/settings/views/settings_drawer.dart';

class DrawerScreen extends StatelessWidget {
  final Widget body;
  final String title;
  final String? subtitle; // Добавляем опциональный подзаголовок

  const DrawerScreen({
    required this.body,
    required this.title,
    super.key,
    this.subtitle, // Инициализация подзаголовка
  });

  @override
  Widget build(BuildContext context) {
    // Определяем количество строк в подзаголовке для динамического изменения высоты AppBar
    int subtitleLines = 1;
    if (subtitle != null) {
      subtitleLines = '\n'.allMatches(subtitle!).length + 1;
    }

    return Scaffold(
      drawer: const SettingsDrawer(),
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: const TextStyle(
                fontSize: 20.0, // Основной заголовок
                fontWeight: FontWeight.bold,
              ),
            ),
            if (subtitle != null)
              Text(
                subtitle!,
                style: const TextStyle(
                  fontSize: 14.0, // Подзаголовок с меньшим шрифтом
                  fontWeight: FontWeight.normal,
                ),
                maxLines: 2, // Максимум 2 строки для подзаголовка
                overflow: TextOverflow.ellipsis, // Троеточие при переполнении
              ),
          ],
        ),
        // Динамическая высота AppBar в зависимости от подзаголовка
        toolbarHeight: subtitle != null ? 80.0 : kToolbarHeight,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Добавляем внутренние отступы
        child: body,
      ),
    );
  }
}
