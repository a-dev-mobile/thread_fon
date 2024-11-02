import 'package:flutter/material.dart';
// Package imports:
import 'package:threadfon/app/language/language_notifier.dart';
import 'package:threadfon/localization/localization.dart';
import 'package:threadfon/core/utils/app_text_styles_extension.dart';
import 'package:threadfon/core/widgets/btn_list_tile.dart';

class LangSwitchWidget extends StatelessWidget {
  const LangSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Используем watch для обновления виджета при изменении языка
    final currentLocale = LanguageNotifier.watch(context);

    return BtnListTile(
      onTap: () {
        Navigator.of(context).restorablePush(_dialogBuilderSelectLang);
      },
      leading: const Icon(Icons.language),
      text: Localization.of(context).app_lang,
      trailing: const Icon(Icons.chevron_right),
    );
  }

  static Route<Object?> _dialogBuilderSelectLang(
    BuildContext context,
    Object? arguments,
  ) {
    // Используем read, так как нам не нужно перестраивать этот виджет при изменении языка
    final languageNotifier = LanguageNotifier.read(context);

    return DialogRoute<void>(
      context: context,
      builder: (context) {
        // Используем watch внутри диалога, чтобы обновлять его содержимое при изменении языка
        final currentLocale = LanguageNotifier.watch(context);

        return SimpleDialog(
          title: Text(
            Localization.of(context).app_lang,
            style: context.textStyle.headlineSmall,
          ),
          children: [
            SimpleDialogOption(
              onPressed: () {
                languageNotifier.setLocale('ru');
                Navigator.pop(context);
              },
              child: Text(
                Localization.of(context).lang_ru,
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                languageNotifier.setLocale('en');
                Navigator.pop(context);
              },
              child: Text(
                Localization.of(context).lang_en,
              ),
            ),
          ],
        );
      },
    );
  }
}
