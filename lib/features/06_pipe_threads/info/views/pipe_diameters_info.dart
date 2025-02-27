import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/info_row_max_min.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/06_pipe_threads/info/models/pipe_info_model.dart';

import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class PipeInfoDiametersParameters extends StatelessWidget {
  final PipeInfoModel info;

  const PipeInfoDiametersParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: info.diameter_info.map((DiameterInfo diameter) {
          return Column(
            children: <Widget>[
              _DiameterSection(
                title: diameter.name,
                diameterData: diameter,
                isHaveDividerBottom: diameter != info.diameter_info.last,
              ),
              if (diameter != info.diameter_info.last)
                const SizedBox(height: 10.0),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _DiameterSection extends StatelessWidget {
  final String title;
  final DiameterInfo diameterData;
  final bool isHaveDividerBottom;

  const _DiameterSection({
    required this.title,
    required this.diameterData,
    this.isHaveDividerBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;

    // Check if we have only min or max value
    final bool hasOnlyMin = diameterData.min.isNotEmpty &&
        diameterData.max.isEmpty &&
        diameterData.basic.isEmpty &&
        diameterData.avg.isEmpty;

    final bool hasOnlyMax = diameterData.max.isNotEmpty &&
        diameterData.min.isEmpty &&
        diameterData.basic.isEmpty &&
        diameterData.avg.isEmpty;

    if (hasOnlyMin) {
      return InfoRowMaxMin(
        label: title,
        value: diameterData.min,
        labelMaxMin: localization.min,
        isHaveDividerBottom: isHaveDividerBottom,
      );
    }

    if (hasOnlyMax) {
      return InfoRowMaxMin(
        label: title,
        value: diameterData.max,
        labelMaxMin: localization.max,
        isHaveDividerBottom: isHaveDividerBottom,
      );
    }

    // Default view for complete diameter data
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
                basic: diameterData.basic,
                es: diameterData.es,
                ei: diameterData.ei,
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
  final String basic;
  final String es;
  final String ei;

  const _DiameterItem({
    required this.basic,
    required this.es,
    required this.ei,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasDEs = es.isNotEmpty;
    final bool hasDEi = ei.isNotEmpty;

    return Row(
      children: <Widget>[
        if (basic.isNotEmpty)
          Text(
            basic,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        if (hasDEs || hasDEi) ...<Widget>[
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (hasDEs)
                Text(
                  es,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              if (hasDEi)
                Text(
                  ei,
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
    // Если значение пустое, возвращаем пустой SizedBox
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }

    // Если значение есть, показываем колонку с label и value
    return Column(
      children: <Widget>[
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        if (value.isNotEmpty)
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
      ],
    );
  }
}
