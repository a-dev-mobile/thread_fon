import 'package:flutter/material.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/localization.dart';
// Package imports:

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    required this.errorMsg,
    super.key,
  });
  final String errorMsg;
  @override
  Widget build(BuildContext context) => Center(
        child: Text('${GeneratedLocalization().generalError} > $errorMsg'),
      );
}
