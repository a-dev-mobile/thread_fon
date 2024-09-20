import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../core/widgets/my_divider.dart';
import 'widget/about_app.dart';
import 'widget/exit_app.dart';
import 'widget/feed_back.dart';
import 'widget/lang_switch.dart';
import 'widget/rate_app.dart';
import 'widget/theme_switch.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).setting),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            ThemeSwitchWidget(),
            MyDivider(),
            LangSwitchWidget(),
            MyDivider(),
            FeedbackWidget(),
            MyDivider(),
            RateAppWidget(),
            MyDivider(),
            AboutAppWidget(),
            MyDivider(),
            ExitAppWidget(),
          ],
        ),
      );
}
