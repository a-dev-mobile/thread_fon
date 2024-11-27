// features/settings/views/about_app.dart

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class AboutApp extends StatefulWidget {
  const AboutApp({super.key});
  static const path = '/AboutApp';
  static const name = 'AboutApp';
  @override
  _AboutAppState createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  String _version = '...';

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return Scaffold(
      appBar: AppBar(
        title: Text(localization.about_app),
      ),
      body: Center( // Центрируем содержимое по горизонтали
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600), // Ограничиваем максимальную ширину
          child: SingleChildScrollView( // Обеспечиваем прокрутку на маленьких экранах
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Занимает минимально необходимое пространство
              children: [
                // Иконка приложения
                Image.asset(
                  'assets/png/icon.png',
                  width: 100,
                  height: 100,
                  semanticLabel: localization.app_icon_alt,
                ),
                SizedBox(height: 16),
                // Название приложения
                Text(
                  localization.app_name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                // Версия приложения
                Text(
                  '${localization.version}: $_version',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 16),
                // Описание приложения
                Text(
                  localization.app_description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                // Дополнительная информация или ссылки
                Text(
                  '© ${DateTime.now().year} ThreadFon',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
