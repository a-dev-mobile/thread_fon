import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../config/styles/app_text_style.dart';
import '../../../core/constants/colors.dart';
import '../../../core/widgets/button/btn_list_tile.dart';
import '../../../core/widgets/my_divider.dart';

class AboutAppWidget extends StatelessWidget {
  const AboutAppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          _showDialogAboutApp(context);
        },
        leading: const Icon(
          Icons.info_outline,
        ),
        text: AppLocalizations.of(context).about,
        // trailing: const Icon(Icons.chevron_right),
      );

  Future<void> _showDialogAboutApp(BuildContext context) async {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    final backgroundColor =
        isDark ? ConstColor.neutral_grey_1000 : ConstColor.neutral_grey_100;
    final packageInfo = await PackageInfo.fromPlatform();

    final appName = AppLocalizations.of(context).app_name;
// String packageName = packageInfo.packageName;
    final version = packageInfo.version;
// String buildNumber = packageInfo.buildNumber;

    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: backgroundColor,
        title: Text(
          '$appName : $version',
          textAlign: TextAlign.center,
          style: AppTextStyle.H3_REGULAR(
            colorText: Theme.of(context).textTheme.bodyText1!.color,
          ),
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
          AppLocalizations.of(context).thank_you,
          textAlign: TextAlign.center,
          style: AppTextStyle.LABEL_SEMI_BOLD(),
        ),
        const MyDivider(),
        Text(
          AppLocalizations.of(context).dialog_title_about_app,
          style: AppTextStyle.LABEL_REGULAR(),
        ),
        Text(
          AppLocalizations.of(context).dialog_about_app_1,
          textAlign: TextAlign.left,
          style: AppTextStyle.LABEL_REGULAR(),
        ),
        Text(
          AppLocalizations.of(context).dialog_about_app_2,
          textAlign: TextAlign.left,
          style: AppTextStyle.LABEL_REGULAR(),
        ),
        Text(
          AppLocalizations.of(context).dialog_about_app_3,
          textAlign: TextAlign.left,
          style: AppTextStyle.LABEL_REGULAR(),
        ),
        const MyDivider(),
        Text(
          AppLocalizations.of(context).dialog_about_app_5,
          style: AppTextStyle.LABEL_SEMI_BOLD(),
        ),
      ];
}
