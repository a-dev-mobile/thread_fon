import 'package:flutter/material.dart';
import 'package:threadfon/core/constant/enum_units.dart';
import 'package:threadfon/core/utils/double_extension.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/info/models/info_model.dart';
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
          _DiameterSection(
            title: localization.diam_major,
            diameter: info.diameter,
            dEs: info.dEs,
            dEi: info.dEi,
            min: info.majorDiamMin,
            avg: info.majorDiamAvg,
            max: info.majorDiamMax,
          ),
          Divider(),
          _DiameterSection(
            title: localization.diam_middle,
            diameter: info.pitchDiamD2,
            dEs: info.d2Es,
            dEi: info.d2Ei,
            min: info.pitchDiamMin,
            avg: info.pitchDiamAvg,
            max: info.pitchDiamMax,
          ),
          Divider(),
          _DiameterSection(
            title: localization.diam_minor,
            diameter: info.minorDiamD1,
            dEs: info.d1Es,
            dEi: info.d1Ei,
            min: info.minorDiamMin,
            avg: info.minorDiamAvg,
            max: info.minorDiamMax,
          ),
          Divider(),
          const SizedBox(height: 32.0),
          Text(
            localization.additional_info,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8.0),
          if (info.threadType == EnumThreadType.male)
            _AdditionalInfoItem(
              label: 'Внутренний диаметр резьбы по дну впадины (d3)',
              value: info.minorDiamD3,
            ),
        ],
      ),
    );
  }
}

class _DiameterSection extends StatelessWidget {
  final String title;
  final double diameter;
  final double? dEs;
  final double? dEi;
  final double min;
  final double avg;
  final double max;

  const _DiameterSection({
    required this.title,
    required this.diameter,
    this.dEs,
    this.dEi,
    required this.min,
    required this.avg,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;

    return Column(
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              localization.tolerance,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            _DiameterItem(
              diameter: diameter,
              dEs: dEs,
              dEi: dEi,
            ),
          ],
        ),
        const SizedBox(height: 6.0),
        
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _ValueItem(label: localization.min , value: min),
            _ValueItem(label: localization.avg, value: avg),
            _ValueItem(label: localization.max, value: max),
          ],
        ),
      ],
    );
  }
}

class _DiameterItem extends StatelessWidget {
  final double diameter;
  final double? dEs;
  final double? dEi;

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
                Text(
                  dEi != null && dEi != 0 ? dEi.toString() : '',
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
  final double value;
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
  final double value;

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
