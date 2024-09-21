import 'package:flutter/material.dart';
import 'package:threadfon/src/common/localization/localization.dart';
// Package imports:

class MyErrorWidget extends StatelessWidget {
  const MyErrorWidget({
    required this.errorMsg,
    super.key,
  });
  final String errorMsg;
  @override
  Widget build(BuildContext context) => Center(
        child: Text('${Localization.of(context).generalError} > $errorMsg'),
      );
}
