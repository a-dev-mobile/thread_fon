import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/localization/l10n_extension.dart';
import 'package:threadfon/features/settings/views/about_app.dart'; // Импортируем экран AboutApp
import 'package:firebase_analytics/firebase_analytics.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  _SettingsDrawerState createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  String _selectedThreadType = 'metric_thread'; // Текущий тип резьбы

  /// Функция для отправки электронной почты
  Future<void> _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'wayofdt@gmail.com',
      queryParameters: {
        'subject': 'Feedback ThreadFon',
      },
    );
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);

        // Логирование отправки электронной почты
        final analytics = RepositoryProvider.of<FirebaseAnalytics>(context);
        analytics.logEvent(name: 'send_feedback_email');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.email_app_not_found)),
        );

        // Логирование ошибки при попытке отправки электронной почты
        final analytics = RepositoryProvider.of<FirebaseAnalytics>(context);
        analytics.logEvent(name: 'send_feedback_email_failed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.email_sending_failed)),
      );

      // Логирование исключения при попытке отправки электронной почты
      final analytics = RepositoryProvider.of<FirebaseAnalytics>(context);
      analytics.logEvent(
        name: 'send_feedback_email_exception',
        parameters: {'error': e.toString()},
      );
    }
  }

  /// Функция для перехода в App Store для iOS
  Future<void> _openAppStoreOrPlayStore() async {
    final String url = Theme.of(context).platform == TargetPlatform.iOS
        ? 'https://apps.apple.com/app/id1602169811' // Ссылка на App Store для iOS
        : 'https://play.google.com/store/apps/details?id=a.dev.mobile.threadfon'; // Ссылка на Google Play для Android

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // Обработка ошибки
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.app_store_not_found)),
      );
    }
  }

  /// Диалог выбора темы
  void _showThemeDialog(BuildContext context, ThemeBloc themeBloc) {
    final localization = context.l10n;
    final analytics = RepositoryProvider.of<FirebaseAnalytics>(context);
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (dialogContext) => AlertDialog(
        title: Text(localization.choose_theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: Text(localization.light_theme),
              value: ThemeMode.light,
              groupValue: themeBloc.state.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeBloc.setTheme(value);
                  Navigator.of(dialogContext).pop(); // Закрыть диалог
                  Navigator.of(context).pop(); // Закрыть Drawer

                  // Логирование изменения темы
                  analytics.logEvent(
                    name: 'theme_changed',
                    parameters: {'theme_mode': 'light'},
                  );
                }
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(localization.dark_theme),
              value: ThemeMode.dark,
              groupValue: themeBloc.state.themeMode,
              onChanged: (value) {
                if (value != null) {
                  themeBloc.setTheme(value);
                  Navigator.of(dialogContext).pop(); // Закрыть диалог
                  Navigator.of(context).pop(); // Закрыть Drawer

                  // Логирование изменения темы
                  analytics.logEvent(
                    name: 'theme_changed',
                    parameters: {'theme_mode': 'dark'},
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Диалог выбора языка
  void _showLanguageDialog(BuildContext context, LanguageBloc languageBloc) {
    final localization = context.l10n;
    final analytics = RepositoryProvider.of<FirebaseAnalytics>(context);
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (dialogContext) => AlertDialog(
        title: Text(localization.choose_language),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: EnumLang.values.map((lang) {
            String langText;
            switch (lang) {
              case EnumLang.en:
                langText = 'English';
                break;
              case EnumLang.ru:
                langText = 'Русский';
                break;
              // Add more languages here if needed
            }
            return RadioListTile<EnumLang>(
              title: Text(langText),
              value: lang,
              groupValue: languageBloc.state.enumLang,
              onChanged: (value) {
                languageBloc.setLanguage(value!);
                Navigator.of(dialogContext).pop(); // Закрыть диалог
                Navigator.of(context).pop(); // Закрыть Drawer

                // Логирование изменения языка
                analytics.logEvent(
                  name: 'language_changed',
                  parameters: {'language': langText},
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  /// Диалог выбора резьбы
  void _showThreadDialog(BuildContext context) {
    final localization = context.l10n;
    final analytics = RepositoryProvider.of<FirebaseAnalytics>(context);
    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (dialogContext) => AlertDialog(
        title: Text(localization.choose_thread),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<String>(
              title: Text(localization.metric_thread),
              value: localization.metric_thread,
              groupValue: localization.metric_thread,
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedThreadType = 'metric_thread';
                  });
                  Navigator.of(dialogContext).pop(); // Закрыть диалог
                  Navigator.of(context).pop(); // Закрыть Drawer

                  // Логирование изменения типа резьбы
                  analytics.logEvent(
                    name: 'thread_type_changed',
                    parameters: {'thread_type': 'metric_thread'},
                  );
                }
              },
            ),
            // В будущем добавьте другие типы резьбы здесь
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final languageBloc = context.read<LanguageBloc>();
    final localization = context.l10n;
    final analytics = RepositoryProvider.of<FirebaseAnalytics>(context);

    return Drawer(
      child: Column(
        children: [
          // Заголовок Drawer
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).primaryColor,
                  Theme.of(context).primaryColorDark,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Название приложения
                Text(
                  localization.app_name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Дополнительный подзаголовок или описание
                Text(
                  localization.settings_header_subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          // Основное содержимое Drawer
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  leading: const Icon(Icons.color_lens),
                  title: Text(localization.choose_theme),
                  onTap: () => _showThemeDialog(context, themeBloc),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text(localization.choose_language),
                  onTap: () => _showLanguageDialog(context, languageBloc),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.build),
                  title: Text(localization.choose_thread),
                  subtitle: Text(localization.metric_thread),
                  onTap: () => _showThreadDialog(context),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.feedback),
                  title: Text(localization.suggest_improvement),
                  onTap: () => _sendEmail(context),
                ),

                const Divider(),
                // Новый пункт меню: Перейти в App Store (для iOS)

                ListTile(
                  leading: const Icon(Icons.store),
                  title: Text(localization.leave_review),
                  onTap: _openAppStoreOrPlayStore,
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: Text(localization.about_app),
                  onTap: () {
                    Navigator.of(context).pop(); // Закрыть Drawer
                    context.pushNamed(AboutApp.name);

                    // Логирование просмотра экрана "About App"
                    analytics.logEvent(name: 'about_app_viewed');
                  },
                ),
                // Добавьте дополнительные пункты настроек здесь, если необходимо
              ],
            ),
          ),
          // Футер Drawer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '© ${DateTime.now().year} ThreadFon',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
