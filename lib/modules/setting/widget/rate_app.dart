import 'dart:io';

import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/common.dart';
import '../../../core/widgets/button/btn_list_tile.dart';

class RateAppWidget extends StatelessWidget {
  const RateAppWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          launchURL();
        },
        leading: const Icon(
          Icons.star_border_outlined,
        ),
        text: AppLocalizations.of(context).rate_app,
        // trailing: const Icon(Icons.chevron_right),
      );

  void launchURL() async {
    final url =
        Platform.isIOS ? ConstCommon.appStoreUrl : ConstCommon.playStoreUrl;

    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
