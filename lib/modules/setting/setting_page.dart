import 'package:flutter/material.dart';
// Package imports:

import 'package:threadfon/core/widgets/my_divider.dart';
import 'package:threadfon/modules/setting/widget/about_app.dart';
import 'package:threadfon/modules/setting/widget/exit_app.dart';
import 'package:threadfon/modules/setting/widget/feed_back.dart';
import 'package:threadfon/modules/setting/widget/lang_switch.dart';
import 'package:threadfon/modules/setting/widget/rate_app.dart';
import 'package:threadfon/modules/setting/widget/theme_switch.dart';
import 'package:threadfon/src/common/localization/localization.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          title: Text(Localization.of(context).setting),
        ),
        body: const Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
