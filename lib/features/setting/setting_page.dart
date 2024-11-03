import 'package:flutter/material.dart';

import 'package:threadfon/localization/generated/l10n.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(
    BuildContext context,
  ) =>
      Scaffold(
        appBar: AppBar(
          title: Text(GeneratedLocalization().setting),
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
