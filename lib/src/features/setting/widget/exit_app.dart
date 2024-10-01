import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// Package imports:

import 'package:threadfon/src/common/styles/app_text_style.dart';
import 'package:threadfon/src/common/constant/colors.dart';
import 'package:threadfon/src/common/widgets/button/btn_list_tile.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class ExitAppWidget extends StatelessWidget {
  const ExitAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          _showDialogExitApp(context);
        },
        leading: const Icon(
          Icons.exit_to_app,
        ),
        text: Localization.of(context).exit_app,
        // trailing: const Icon(Icons.chevron_right),
      );

  Future<void> _showDialogExitApp(BuildContext context) async {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final backgroundColor = isDark ? ConstColor.neutral_grey_1000 : ConstColor.neutral_grey_100;

    final title = Localization.of(context).exit_app_warning;
    final yes = Localization.of(context).yes;
    final no = Localization.of(context).no;

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: AppTextStyle.H3_REGULAR(
              // colorText: Theme.of(context).textTheme.bodyText1!.color,
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
