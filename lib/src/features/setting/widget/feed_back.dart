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
        
        },
        leading: const Icon(Icons.feedback_outlined),
        text: Localization.of(context).feedback,
        // trailing: const Icon(Icons.chevron_right),
      );


}
