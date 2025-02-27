import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/widgets/info_row.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/05_trapezoidal_threads/info/bloc/trapezoidal_info_bloc.dart';
import 'package:threadfon/features/05_trapezoidal_threads/info/models/trapezoidal_info_model.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class TrapezoidalInfoMainParameters extends StatelessWidget {
  final TrapezoidalInfoModel info;

  const TrapezoidalInfoMainParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final EnumUnits units = context.read<TrapezoidalInfoBloc>().state.units;
    final String unitsText =
        units == EnumUnits.mm ? localization.mm_long : localization.inch;

    return MyCard(
      child: Column(
        children: <Widget>[
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
          const SizedBox(height: 8.0),
          Text(
            '${localization.units}: $unitsText',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16.0),
          const Divider(),
          // Display main_info items
          ...info.main_info.map((MainInfo item) {
            return InfoRow(
              label: item.name,
              value: item.value,
              isHaveDividerBottom: item != info.main_info.last,
            );
          }),
        ],
      ),
    );
  }
}
