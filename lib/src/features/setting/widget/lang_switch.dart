import 'package:flutter/material.dart';
// Package imports:
import 'package:threadfon/src/common/app/language_notifier.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/common/styles/app_text_styles_extension.dart';
import 'package:threadfon/src/common/widgets/button/btn_list_tile.dart';

class LangSwitchWidget extends StatelessWidget {
  const LangSwitchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          Navigator.of(context).restorablePush(_dialogBuilderSelectLang);
        },
        leading: const Icon(Icons.language),
        text: Localization.of(context).app_lang,
        trailing: const Icon(Icons.chevron_right),
      );

  static Route<Object?> _dialogBuilderSelectLang(
    BuildContext context,
    Object? arguments,
  ) {
    final languageNotifier = LanguageNotifier.ofNotifier(context)!;

    return DialogRoute<void>(
      context: context,
      builder: (context) => SimpleDialog(
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
      ),
    );
  }
}
