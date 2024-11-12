import 'package:flutter/material.dart';
import 'package:threadfon/core/utils/double_extension.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/info/models/info_model.dart';
import 'package:threadfon/features/info/views/info_row.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class InfoMainParameters extends StatelessWidget {
  final InfoModel info;

  const InfoMainParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return MyCard(
      child: Column(
        children: [
          Text(
            localization.thread_designation,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            info.designation,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            info.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            info.typePitchDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16.0),
          const Divider(),
          InfoRow(label: localization.thread_diam_nom, value: info.diameter),
          InfoRow(label: localization.pitch, value: info.pitch),
          InfoRow(label: localization.thread_depth, value: info.threadDepth),
          InfoRow(label: localization.thread_class_tolerance, value: info.tolerance),
          InfoRow(label: localization.type_pitch, value: info.typePitchDescription),
        ],
      ),
    );
  }
}
