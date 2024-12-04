import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/services/local_storage/local_storage.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';
import 'package:threadfon/core/widgets/my_error_widget.dart';
import 'package:threadfon/features/settings/bloc/settings_bloc.dart';
import 'package:threadfon/main.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:threadfon/app/language/language_bloc.dart';
import 'package:threadfon/app/theme/theme_bloc.dart';
import 'package:threadfon/localization/l10n_extension.dart';
import 'package:threadfon/features/settings/views/about_app.dart'; // Импортируем экран AboutApp

final _logger = LogService('settings_drawer');

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  late SettingsBloc settingsBloc;
  late ThemeBloc themeBloc;
  late LanguageBloc languageBloc;
  late LocalStorage localStorage;

  @override
  void initState() {
    super.initState();

    localStorage = context.read<LocalStorage>();
    languageBloc = context.read<LanguageBloc>();
    themeBloc = context.read<ThemeBloc>();

    settingsBloc = SettingsBloc(
      localStorage: localStorage,
      languageBloc: languageBloc,
    )..load();
  }

  @override
  void dispose() {
    settingsBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => settingsBloc,
      child: _SettingsDrawerView(
          settingsBloc, themeBloc, languageBloc, localStorage),
    );
  }
}

class _SettingsDrawerView extends StatelessWidget {
  const _SettingsDrawerView(
      this.bloc, this.themeBloc, this.languageBloc, this.localStorage);
  final SettingsBloc bloc;
  final ThemeBloc themeBloc;
  final LanguageBloc languageBloc;
  final LocalStorage localStorage;

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, settingsState) {
        final currentThreadType = settingsState.enumThreads;
        String threadTypeText;
        switch (currentThreadType) {
          case EnumThreads.metric:
            threadTypeText = localization.metric_thread;
            break;
          case EnumThreads.imperialThread:
            threadTypeText = localization.imperial_thread;
            break;
        }

        return Drawer(
          child: Stack(
            children: [
              BlocBuilder<SettingsBloc, SettingsState>(
                buildWhen: (previous, current) =>
                    previous.enumPageStatus != current.enumPageStatus,
                builder: (context, state) {
                  switch (state.enumPageStatus) {
                    case EnumStatus.loading:
                      return const LoadingWidget();

                    case EnumStatus.error:
                      return MyErrorWidget(
                        errorMsg: state.errorMsg,
                        onRetry: () => bloc.load(),
                      );
                    case EnumStatus.success:
                      return Column(
                        children: [
                          // Drawer Header
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                                vertical: 50, horizontal: 20),
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
                                // App Name
                                Text(
                                  localization.app_name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                // Subtitle
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
                          // Drawer Content
                          Expanded(
                            child: ListView(
                              children: [
                                ListTile(
                                  leading: const Icon(Icons.color_lens),
                                  title: Text(localization.choose_theme),
                                  onTap: () => _showThemeDialog(context),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.language),
                                  title: Text(localization.choose_language),
                                  onTap: () => _showLanguageDialog(context),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.build),
                                  title: Text(localization.choose_thread),
                                  subtitle: Text(threadTypeText),
                                  onTap: () => _showThreadDialog(context),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.feedback),
                                  title: Text(localization.suggest_improvement),
                                  onTap: () => _sendEmail(context),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.store),
                                  title: Text(localization.leave_review),
                                  onTap: () =>
                                      _openAppStoreOrPlayStore(context),
                                ),
                                const Divider(),
                                ListTile(
                                  leading: const Icon(Icons.info),
                                  title: Text(localization.about_app),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                    context.pushNamed(AboutApp.name);

                                    // Log viewing About App screen
                                    analytics.logEvent(
                                        name: 'about_app_viewed');
                                  },
                                ),
                                // Add more settings options here
                              ],
                            ),
                          ),
                          // Drawer Footer
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
                      );
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  /// Function to send an email
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

        // Logging email send event
        analytics.logEvent(name: 'send_feedback_email');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.email_app_not_found)),
        );

        // Logging email send failure
        analytics.logEvent(name: 'send_feedback_email_failed');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.email_sending_failed)),
      );

      // Logging email send exception
      analytics.logEvent(
        name: 'send_feedback_email_exception',
        parameters: {'error': e.toString()},
      );
    }
  }

  /// Function to open App Store or Play Store
  Future<void> _openAppStoreOrPlayStore(BuildContext context) async {
    final String url = Theme.of(context).platform == TargetPlatform.iOS
        ? 'https://apps.apple.com/app/id1602169811'
        : 'https://play.google.com/store/apps/details?id=a.dev.mobile.threadfon';

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.app_store_not_found)),
      );
    }
  }

  /// Dialog to choose theme
  void _showThemeDialog(BuildContext context) {
    final localization = context.l10n;

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

                  dialogContext.pop();
                  context.pop(); // Закрыть Drawer

                  // Log theme change
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
                  dialogContext.pop(); // Закрыть диалог
                  context.pop(); // Закрыть Drawer

                  // Log theme change
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

  /// Dialog to choose language
  void _showLanguageDialog(BuildContext context) {
    final localization = context.l10n;

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
            }
            return RadioListTile<EnumLang>(
              title: Text(langText),
              value: lang,
              groupValue: languageBloc.state.enumLang,
              onChanged: (value) {
                languageBloc.setLanguage(value!);
                dialogContext.pop(); // Закрыть диалог
                context.pop(); // Закрыть Drawer

                // Log language change
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

  /// Dialog to choose thread type
  void _showThreadDialog(BuildContext context) {
    final localization = context.l10n;
    final currentThreadType = bloc.state.enumThreads;

    showDialog(
      context: context,
      useRootNavigator: true,
      builder: (dialogContext) => AlertDialog(
        title: Text(localization.choose_thread),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: EnumThreads.values.map((threadType) {
            String threadTypeText;
            switch (threadType) {
              case EnumThreads.metric:
                threadTypeText = localization.metric_thread;
                break;
              case EnumThreads.imperialThread:
                threadTypeText = localization.imperial_thread;
                break;
            }
            return RadioListTile<EnumThreads>(
              title: Text(threadTypeText),
              value: threadType,
              groupValue: currentThreadType,
              onChanged: (value) {
                if (value != null) {
                  bloc.setThreadType(value);
                  dialogContext.pop();
                  context.pop();

                  // Log thread type change
                  analytics.logEvent(
                    name: 'thread_type_changed',
                    parameters: {'thread_type': threadType.toString()},
                  );
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
