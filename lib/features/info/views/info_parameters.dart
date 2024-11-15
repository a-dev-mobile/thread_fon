import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/info/models/info_model.dart';
import 'package:threadfon/features/info/views/info_row.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class InfoParameters extends StatelessWidget {
  final InfoModel info;

  const InfoParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
/* 
Summary of Names in the Metric Thread Handbook:

𝐻
/
8
H/8: Снятие на вершине резьбы (Crest Truncation)
𝐻
/
4
H/4: Снятие на впадине резьбы (Root Truncation)
3
𝐻
/
8
3H/8: Суммарное снятие (Total Truncation)
5
𝐻
/
8
5H/8: Рабочая высота профиля резьбы (Working Height of the Thread Profile)
𝑃
/
2
P/2: Полушаг резьбы (Half Pitch)
𝑃
/
4
P/4: Четверть шага резьбы (Quarter Pitch)
𝑃
/
8
P/8: Одна восьмая шага резьбы (Eighth of Pitch)

 */
    return MyCard(
      child: Column(
        children: [
          InfoRow(
            label: localization.heightOfFundamentalTriangle,
            value: info.h.toString(),
          ),
          InfoRow(
            label: localization.workingHeightOfProfile,
            value: info.fiveHDiv8.toString(),
          ),
          InfoRow(
            label: localization.crestTruncation,
            value: info.hDiv8.toString(),
          ),
          InfoRow(
            label: localization.rootTruncation,
            value: info.hDiv4.toString(),
          ),
          InfoRow(
            label: localization.totalTruncation,
            value: info.threeHDiv8.toString(),
          ),
          InfoRow(
            label: localization.halfPitch,
            value: info.pitchDiv2.toString(),
          ),
          InfoRow(
            label: localization.quarterPitch,
            value: info.pitchDiv4.toString(),
          ),
          InfoRow(
            label: localization.eighthPitch,
            value: info.pitchDiv8.toString(),
          ),
        ],
      ),
    );
  }
}
