import 'dart:math';

import 'package:flutter/material.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n.dart';
import 'package:threadfon/localization/localization.dart';

class MyLoadWidget extends StatelessWidget {
  const MyLoadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            context.l10n.loadingMessage,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
