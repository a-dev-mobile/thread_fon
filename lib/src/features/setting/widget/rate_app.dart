import 'dart:io';

import 'package:flutter/material.dart';
// Package imports:

import 'package:threadfon/src/common/constant/common.dart';
import 'package:threadfon/src/common/widgets/button/btn_list_tile.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:url_launcher/url_launcher.dart';

class RateAppWidget extends StatelessWidget {
  const RateAppWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          launchURL();
        },
        leading: const Icon(
          Icons.star_border_outlined,
        ),
        text: Localization.of(context).rate_app,
        // trailing: const Icon(Icons.chevron_right),
      );

  Future<void> launchURL() async {
    final url = Platform.isIOS ? ConstCommon.appStoreUrl : ConstCommon.playStoreUrl;

    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}
