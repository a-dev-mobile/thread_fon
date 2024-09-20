import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    Key? key,
    required this.errorMsg,
  }) : super(key: key);
  final String errorMsg;
  @override
  Widget build(BuildContext context) => Center(
        child: Text('${AppLocalizations.of(context).generalError} > $errorMsg'),
      );
}
