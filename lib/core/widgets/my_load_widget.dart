import 'package:flutter/material.dart';
import 'package:threadfon/localization/localization.dart';
// Package imports:

class MyLoadWidget extends StatelessWidget {
  const MyLoadWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) =>
      Center(child: Text(Localization.of(context).loadingMessage));
}
