import 'package:flutter/material.dart';
// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/constants/common.dart';
import '../../../core/widgets/button/btn_list_tile.dart';

class FeedbackWidget extends StatelessWidget {
  const FeedbackWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => BtnListTile(
        onTap: () {
          launch(emailLaunchUri(context).toString());
        },
        leading: const Icon(Icons.feedback_outlined),
        text: AppLocalizations.of(context).feedback,
        // trailing: const Icon(Icons.chevron_right),
      );

  Uri emailLaunchUri(BuildContext context) => Uri(
        scheme: 'mailto',
        path: ConstCommon.email,
        query:
            '${Uri.encodeComponent('subject')}=${Uri.encodeComponent('${AppLocalizations.of(context).feedback} -> ${AppLocalizations.of(context).app_name}')}',
      );
}
