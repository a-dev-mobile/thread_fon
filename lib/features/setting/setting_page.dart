import 'package:flutter/material.dart';

import 'package:threadfon/features/setting/widgets/theme_switch.dart';
import 'package:threadfon/localization/localization.dart';
import 'package:threadfon/features/setting/widgets/lang_switch.dart';


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
            // ThemeSwitchWidget(),
    
            // LangSwitchWidget(),

          ],
        ),
      );
}
