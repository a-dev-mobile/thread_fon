import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';

import 'package:threadfon/features/05_trapezoidal_threads/info/models/trapezoidal_info_model.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class TrapezoidalInfoDiametersParameters extends StatelessWidget {
  final TrapezoidalInfoModel info;

  const TrapezoidalInfoDiametersParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final bool isFemale = info.type == 'female';
    final String prefix = isFemale ? 'D' : 'd';

    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _DiameterSection(
            title: '$prefix - ${localization.diam_major}',
            diameterData: info.major_diameter,
          ),
          const SizedBox(height: 10.0),
          _DiameterSection(
            title: '${prefix}2 - ${localization.diam_middle}',
            diameterData: info.pitch_diameter,
          ),
          const SizedBox(height: 10.0),
          _DiameterSection(
            title: '${prefix}1 - ${localization.diam_minor}',
            diameterData: info.minor_diameter,
            isHaveDividerBottom: false,
          ),
        ],
      ),
    );
  }
}

class _DiameterSection extends StatelessWidget {
  final String title;
  final DiameterData diameterData;
  final bool isHaveDividerBottom;

  const _DiameterSection({
    required this.title,
    required this.diameterData,
    this.isHaveDividerBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: isHaveDividerBottom
              ? const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                      width: 0.2,
                    ),
                  ),
                )
              : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(width: 8.0),
              _DiameterItem(
                diameter: diameterData.basic,
                dEs: diameterData.es,
                dEi: diameterData.ei,
              ),
            ],
          ),
        ),
        const SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _ValueItem(label: localization.min, value: diameterData.min),
            _ValueItem(label: localization.avg, value: diameterData.avg),
            _ValueItem(label: localization.max, value: diameterData.max),
          ],
        ),
      ],
    );
  }
}

class _DiameterItem extends StatelessWidget {
  final String diameter;
  final String? dEs;
  final String? dEi;

  const _DiameterItem({
    required this.diameter,
    this.dEs,
    this.dEi,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDEs = dEs != null && dEs!.isNotEmpty;
    final bool hasDEi = dEi != null && dEi!.isNotEmpty;



    return Row(
      children: <Widget>[
        Text(
          diameter.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (hasDEs || hasDEi) ...<Widget>[
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (hasDEs)
                Text(
                  dEs!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              if (hasDEi)
                Text(
                  dEi!,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            ],
          ),
        ],
      ],
    );
  }
}

class _ValueItem extends StatelessWidget {
  final String value;
  final String label;

  const _ValueItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
