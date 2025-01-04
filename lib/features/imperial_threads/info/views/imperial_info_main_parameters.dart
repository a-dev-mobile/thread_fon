import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/core/constant/enum_thread_male_female.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/imperial_threads/info/bloc/imperial_info_bloc.dart';

import 'package:threadfon/features/imperial_threads/info/models/imperial_info_model.dart';
import 'package:threadfon/features/imperial_threads/info/views/imperial_info_row.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class ImperialInfoMainParameters extends StatelessWidget {
  final ImperialInfoModel info;

  const ImperialInfoMainParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final EnumUnits units = context.read<ImperialInfoBloc>().state.units;
    final String unitsText =
        units == EnumUnits.mm ? localization.mm : localization.inch;

    return MyCard(
      child: Column(
        children: <Widget>[
          Text(
            info.designation1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          if (info.designation1 != info.designation2)
            Text(
              '(${info.designation2})',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
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
          // Text(
          //   'info.typePitchDescription',
          //   textAlign: TextAlign.center,
          //   style: Theme.of(context).textTheme.labelSmall?.copyWith(
          //         fontWeight: FontWeight.bold,
          //       ),
          // ),
          // Добавьте этот блок кода
          const SizedBox(height: 8.0),
          Text(
            '${localization.units}: $unitsText',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          // Конец добавления
          const SizedBox(height: 16.0),
          const Divider(),
          ImperialInfoRow(
              label: localization.thread_type,
              value: info.type_.isFemale
                  ? localization.internal_thread
                  : localization.external_thread),
          ImperialInfoRow(
            label: localization.thread_diam_nom,
            value: info.decimal_diameter.toString(),
          ),
          ImperialInfoRow(
            label: localization.tpi,
            value: info.tpi.toString(),
          ),
          ImperialInfoRow(
            label: localization.thread_series,
            value: info.series_designation,
          ),
          ImperialInfoRow(
            label: localization.thread_class,
            value: info.series,
          ),

          ImperialInfoRow(
            label: localization.pitch,
            value: info.pitch.toString(),
          ),

          ImperialInfoRow(
            isHaveDividerBottom: false,
            label: localization.thread_depth,
            value: info.thread_depth.toString(),
          ),

          // ImperialInfoRow(
          //   label: 'localization.allowance',
          //   value: info.allowance.toString(),
          // ),
        ],
      ),
    );
  }
}
