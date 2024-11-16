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

/* 
Rmax – Maximum root radius of thread
Rmin – Minimum root radius of thread

 */
                    InfoRow(
            label: 'Rmax – Максимальный радиус закругления впадины резьбы',
            value: info.rMax.toString(),
          ),
                              InfoRow(
            label: 'Rmin – Минимальный радиус закругления впадины резьбы',
            value: info.rMin.toString(),
          ),

                InfoRow(
            label: 'Cmin — Минимальная усечённость вершины резьбы',
            value: info.cMax.toString(),
          ),
          InfoRow(
            label: 'Cmax — Максимальная усечённость вершины резьбы',
            value: info.cMin.toString(),
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
