import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/app/language_notifier.dart';
import 'package:threadfon/config/styles/app_text_style.dart';
import 'package:threadfon/core/constants/colors.dart';
import 'package:threadfon/core/widgets/button/btn_list_tile.dart';
import 'package:threadfon/modules/setting/cubit/toggle_lang_cubit.dart';
import 'package:threadfon/src/common/localization/localization.dart';

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
          style: AppTextStyle.H3_REGULAR(context: context),
        ),
        children: [
          SimpleDialogOption(
            onPressed: () {
              languageNotifier.setLocale('ru');
              Navigator.pop(context);
            },
            child: Text(
              Localization.of(context).lang_ru,
              style: AppTextStyle.BODY_SEMI_BOLD(),
            ),
          ),
          SimpleDialogOption(
            onPressed: () {
              languageNotifier.setLocale('en');

              Navigator.pop(context);
            },
            child: Text(
              Localization.of(context).lang_en,
              style: AppTextStyle.BODY_SEMI_BOLD(),
            ),
          ),
        ],
      ),
    );
  }
}
