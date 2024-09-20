import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyLoadWidget extends StatelessWidget {
  const MyLoadWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Center(child: Text(AppLocalizations.of(context).load));
}
