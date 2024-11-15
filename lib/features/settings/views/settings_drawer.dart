// features/settings/views/settings_drawer.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({super.key});

  Future<void> _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'wayofdt@gmail.com', // Updated email address
      queryParameters: {
        'subject': 'Feedback',
      },
    );
    try {
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.email_app_not_found)),
        );
      }
    } catch (e) {
      // Handle any exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.email_sending_failed)),
      );
    }
  }

  /// Displays a dialog to choose between Light and Dark themes.
  void _showThemeDialog(BuildContext context, ThemeBloc themeBloc) {
    final localization = context.l10n;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(localization.choose_theme),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RadioListTile<ThemeMode>(
              title: Text(localization.light_theme),
              value: ThemeMode.light,
              groupValue: themeBloc.state.themeMode,
              onChanged: (value) {
                themeBloc.setTheme(value!);
                Navigator.of(context).pop();
              },
            ),
            RadioListTile<ThemeMode>(
              title: Text(localization.dark_theme),
              value: ThemeMode.dark,
              groupValue: themeBloc.state.themeMode,
              onChanged: (value) {
                themeBloc.setTheme(value!);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Displays a dialog to choose the application language.
  void _showLanguageDialog(BuildContext context, LanguageBloc languageBloc) {
    final localization = context.l10n;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
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
                Navigator.of(context).pop();
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final languageBloc = context.read<LanguageBloc>();
    final localization = context.l10n;

    return Drawer(
      child: Column(
        children: [
          // Кастомный заголовок Drawer
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: Theme.of(context).primaryColor,
            child: Column(
              children: [
                Icon(
                  Icons.menu_book,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 10),
                Text(
                  localization.app_name,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
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
                  leading: Icon(Icons.color_lens),
                  title: Text(localization.choose_theme),
                  onTap: () => _showThemeDialog(context, themeBloc),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.language),
                  title: Text(localization.choose_language),
                  onTap: () => _showLanguageDialog(context, languageBloc),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.feedback),
                  title: Text(localization.leave_feedback),
                  onTap: () => _sendEmail(context),
                ),
                // Добавьте дополнительные пункты настроек здесь, если необходимо
              ],
            ),
          ),
          // Футер Drawer (опционально)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '© ${DateTime.now().year} ThreadApp',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
