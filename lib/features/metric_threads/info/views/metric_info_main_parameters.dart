import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/core/constant/enum_thread%20copy.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/metric_threads/info/bloc/metric_info_bloc.dart';
import 'package:threadfon/features/metric_threads/info/models/metric_info_model.dart';
import 'package:threadfon/features/metric_threads/info/views/metric_info_row.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class MetricInfoMainParameters extends StatelessWidget {
  final MetricInfoModel info;

  const MetricInfoMainParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final units = context.read<MetricInfoBloc>().state.units;
    final unitsText =
        units == EnumUnits.mm ? localization.mm : localization.inch;

    return MyCard(
      child: Column(
        children: [
          Text(
            info.designation,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
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
          InfoRow(
              label: localization.thread_type,
              value: info.threadType == EnumThreadMaleFemale.female
                  ? localization.internal_thread
                  : localization.external_thread),
          InfoRow(
            label: localization.thread_diam_nom,
            value: info.diameter.toString(),
          ),
          InfoRow(
            label: localization.pitch,
            value: info.pitch.toString(),
          ),
          InfoRow(
            label: localization.thread_depth,
            value: info.threadDepth.toString(),
          ),
          InfoRow(
            label: localization.thread_class_tolerance,
            value: info.tolerance,
          ),
          InfoRow(
            label: localization.type_pitch,
            value: info.typePitchDescription,
          ),
        ],
      ),
    );
  }
}
