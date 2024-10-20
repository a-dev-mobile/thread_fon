import 'package:flutter/material.dart';
// Package imports:

import 'package:threadfon/src/common/constant/common.dart';
import 'package:threadfon/src/common/localization/localization.dart';
import 'package:threadfon/src/common/widgets/button/btn_list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          launch(emailLaunchUri(context).toString());
        },
        leading: const Icon(Icons.feedback_outlined),
        text: Localization.of(context).feedback,
        // trailing: const Icon(Icons.chevron_right),
      );

  Uri emailLaunchUri(BuildContext context) => Uri(
        scheme: 'mailto',
        path: ConstCommon.email,
        query:
            '${Uri.encodeComponent('subject')}=${Uri.encodeComponent('${Localization.of(context).feedback} -> ${Localization.of(context).app_name}')}',
      );
}
