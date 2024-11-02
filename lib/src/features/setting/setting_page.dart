import 'package:flutter/material.dart';
import 'package:threadfon/src/common/localization/localization.dart';
// Package imports:


import 'package:threadfon/src/features/setting/widget/about_app.dart';
import 'package:threadfon/src/features/setting/widget/exit_app.dart';
import 'package:threadfon/src/features/setting/widget/feed_back.dart';
import 'package:threadfon/src/features/setting/widget/lang_switch.dart';
import 'package:threadfon/src/features/setting/widget/rate_app.dart';
import 'package:threadfon/src/features/setting/widget/theme_switch.dart';

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
    
            LangSwitchWidget(),

            FeedbackWidget(),
   
            RateAppWidget(),
     
            AboutAppWidget(),
       
            ExitAppWidget(),
          ],
        ),
      );
}
