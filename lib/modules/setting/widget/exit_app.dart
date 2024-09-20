import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../config/styles/app_text_style.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/button/btn_list_tile.dart';

class ExitAppWidget extends StatelessWidget {
  const ExitAppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          _showDialogExitApp(context);
        },
        leading: const Icon(
          Icons.exit_to_app,
        ),
        text: AppLocalizations.of(context).exit_app,
        // trailing: const Icon(Icons.chevron_right),
      );

  Future<void> _showDialogExitApp(BuildContext context) async {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final backgroundColor =
        isDark ? ConstColor.neutral_grey_1000 : ConstColor.neutral_grey_100;

    final title = AppLocalizations.of(context).exit_app_warning;
    final yes = AppLocalizations.of(context).yes;
    final no = AppLocalizations.of(context).no;

    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.H3_REGULAR(
            colorText: Theme.of(context).textTheme.bodyText1!.color,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Platform.isIOS ? exit(0) : SystemNavigator.pop();
            },
            child: Text(yes),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(no),
          ),
        ],
      ),
    );
  }
}
