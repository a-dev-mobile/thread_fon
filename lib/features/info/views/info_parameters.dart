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
InfoRow(
            label: localization.d3_label,
            value: info.minorDiamD3.toString(),
          ),
          InfoRow(
            label: localization.cmin_label,
            value: info.cMin.toString(),
          ),
          InfoRow(
            label: localization.cmax_label,
            value: info.cMax.toString(),
          ),
          InfoRow(
            label: localization.rmax_label,
            value: info.rMax.toString(),
          ),
          InfoRow(
            label: localization.rmin_label,
            value: info.rMin.toString(),
          ),
        ],
      ),
    );
  }
}
