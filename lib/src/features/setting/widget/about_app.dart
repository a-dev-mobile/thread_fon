import 'package:flutter/material.dart';
import 'package:threadfon/src/common/constant/colors.dart';
import 'package:threadfon/src/common/localization/localization.dart';
// Package imports:

import 'package:threadfon/src/common/styles/app_text_styles_extension.dart';
import 'package:threadfon/src/common/widgets/button/btn_list_tile.dart';
import 'package:threadfon/src/common/widgets/my_divider.dart';

class AboutAppWidget extends StatelessWidget {
  const AboutAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          _showDialogAboutApp(context);
        },
        leading: const Icon(
          Icons.info_outline,
        ),
        text: Localization.of(context).about,
        // trailing: const Icon(Icons.chevron_right),
      );

  Future<void> _showDialogAboutApp(BuildContext context) async {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final backgroundColor = isDark ? ConstColor.neutral_grey_1000 : ConstColor.neutral_grey_100;

    final appName = Localization.of(context).app_name;
// String packageName = packageInfo.packageName;

// String buildNumber = packageInfo.buildNumber;

    return showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          '$appName : version',
          textAlign: TextAlign.center,
 
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: buildDialog(context),
        ),
      ),
    );
  }

  List<Widget> buildDialog(BuildContext context) => [
        Text(
          Localization.of(context).thank_you,
          textAlign: TextAlign.center,
      
        ),
        const MyDivider(),
        Text(
          Localization.of(context).dialog_title_about_app,
      
        ),
        Text(
          Localization.of(context).dialog_about_app_1,
          textAlign: TextAlign.left,
     
        ),
        Text(
          Localization.of(context).dialog_about_app_2,
          textAlign: TextAlign.left,
        
        ),
        Text(
          Localization.of(context).dialog_about_app_3,
          textAlign: TextAlign.left,
     
        ),
        const MyDivider(),
        Text(
          Localization.of(context).dialog_about_app_5,
        
        ),
      ];
}
