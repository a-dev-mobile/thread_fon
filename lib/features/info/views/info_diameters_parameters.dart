import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/info/models/info_model.dart';
import 'package:threadfon/features/info/views/info_row.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class InfoDiametersParameters extends StatelessWidget {
  final InfoModel info;

  const InfoDiametersParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return MyCard(
      onTap: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (info.threadType == EnumThreadType.female)
            _DiameterSection(
              title: 'D1 - ${localization.diam_minor}',
              diameter: info.minorDiamD1,
              dEs: info.d1Es,
              dEi: info.d1Ei,
              min: info.minorDiamMin,
              avg: info.minorDiamAvg,
              max: info.minorDiamMax,
            ),
          if (info.threadType == EnumThreadType.male) ...[
            _DiameterSection(
              title: 'd - ${localization.diam_major}',
              diameter: info.diameter,
              dEs: info.dEs,
              dEi: info.dEi,
              min: info.majorDiamMin,
              avg: info.majorDiamAvg,
              max: info.majorDiamMax,
            ),
          ],
          const SizedBox(height: 10.0),
          if (info.holeDiameter != null) ...[
            InfoRow(
              label: localization.threadHoleDiameter,
              value: info.holeDiameter.toString(),
            ),
            const SizedBox(height: 10.0),
          ],
          _DiameterSection(
            title: '${info.threadType == EnumThreadType.female ? 'D2' : 'd2'} - ${localization.diam_middle}',
            diameter: info.pitchDiamD2,
            dEs: info.d2Es,
            dEi: info.d2Ei,
            min: info.pitchDiamMin,
            avg: info.pitchDiamAvg,
            max: info.pitchDiamMax,
          ),
          const SizedBox(height: 10.0),
          if (info.threadType == EnumThreadType.male)
            _DiameterSection(
              title: 'd1 - ${localization.diam_minor}',
              diameter: info.minorDiamD1,
              dEs: info.d1Es,
              dEi: info.d1Ei,
              min: info.minorDiamMin,
              avg: info.minorDiamAvg,
              max: info.minorDiamMax,
            ),
          if (info.threadType == EnumThreadType.female) ...[
            _DiameterSection(
              title: 'D - ${localization.diam_major}',
              diameter: info.diameter,
            ),
          ],
          if (info.threadType == EnumThreadType.male) ...[
            _DiameterSection(
              title: localization.d3_label,
              diameter: info.minorDiamD3,
              dEs: info.d3Es,
              dEi: info.d3Ei,
              min: info.minorDiamMinD3,
              avg: info.minorDiamAvgD3,
              max: info.minorDiamMaxD3,
            )
          ],
        ],
      ),
    );
  }
}

class _DiameterSection extends StatelessWidget {
  final String title;
  final num diameter;
  final num? dEs;
  final num? dEi;
  final num? min;
  final num? avg;
  final num? max;

  const _DiameterSection({
    required this.title,
    required this.diameter,
    this.dEs,
    this.dEi,
    this.min,
    this.avg,
    this.max,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.2,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              SizedBox(width: 8.0),
              _DiameterItem(
                diameter: diameter,
                dEs: dEs,
                dEi: dEi,
              ),
            ],
          ),
        ),
        if (min != null && avg != null && max != null) ...[
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ValueItem(label: localization.min, value: min!),
              _ValueItem(label: localization.avg, value: avg!),
              _ValueItem(label: localization.max, value: max!),
            ],
          ),
        ]
      ],
    );
  }
}

class _DiameterItem extends StatelessWidget {
  final num diameter;
  final num? dEs;
  final num? dEi;

  const _DiameterItem({
    required this.diameter,
    this.dEs,
    this.dEi,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          diameter.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (dEs != null || dEi != null) ...[
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dEs != null && dEs != 0 ? dEs.toString() : '',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              if (dEi != null && dEi != 0)
                Text(
                  dEi.toString(),
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
  final num value;
  final String label;

  const _ValueItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}

class _AdditionalInfoItem extends StatelessWidget {
  final String label;
  final num value;

  const _AdditionalInfoItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        _DiameterItem(
          diameter: value,
        ),
      ],
    );
  }
}
