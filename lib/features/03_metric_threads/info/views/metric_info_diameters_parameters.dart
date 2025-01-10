import 'package:flutter/material.dart';
import 'package:threadfon/core/constant/enum_thread_male_female.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/03_metric_threads/info/models/metric_info_model.dart';
import 'package:threadfon/features/03_metric_threads/info/views/metric_info_row.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class MetricInfoDiametersParameters extends StatelessWidget {
  final MetricInfoModel info;

  const MetricInfoDiametersParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final GeneratedLocalization localization = context.l10n;
    final bool isFemale = info.threadType == EnumThreadMaleFemale.female;
    final String prefix = isFemale ? 'D' : 'd';

    // Создаем список виджетов секций диаметров
    final List<Widget> diameterSections = <Widget>[];

    // Добавляем первую секцию диаметров в зависимости от типа резьбы
    diameterSections
        .add(_buildPrimaryDiameterSection(prefix, isFemale, localization));

    // Добавляем отступ
    diameterSections.add(const SizedBox(height: 10.0));

    // Добавляем информацию о диаметре отверстия, если она существует
    if (info.holeDiameter != null) {
      diameterSections.add(InfoRow(
        label: localization.threadHoleDiameter,
        value: info.holeDiameter.toString(),
      ));
      diameterSections.add(const SizedBox(height: 10.0));
    }

    // Добавляем среднюю секцию диаметра
    diameterSections.add(_DiameterSection(
      title: '${prefix}2 - ${localization.diam_middle}',
      diameter: info.pitchDiamD2,
      dEs: info.d2Es,
      dEi: info.d2Ei,
      min: info.pitchDiamMin,
      avg: info.pitchDiamAvg,
      max: info.pitchDiamMax,
    ));
    diameterSections.add(const SizedBox(height: 10.0));

    // Добавляем дополнительные секции в зависимости от типа резьбы
    diameterSections
        .addAll(_buildAdditionalSections(prefix, isFemale, localization));

    return MyCard(
      onTap: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: diameterSections,
      ),
    );
  }

  // Метод для создания основной секции диаметра
  Widget _buildPrimaryDiameterSection(
      String prefix, bool isFemale, GeneratedLocalization localization) {
    if (isFemale) {
      return _DiameterSection(
        title: '${prefix}1 - ${localization.diam_minor}',
        diameter: info.minorDiamD1,
        dEs: info.d1Es,
        dEi: info.d1Ei,
        min: info.minorDiamMin,
        avg: info.minorDiamAvg,
        max: info.minorDiamMax,
      );
    } else {
      return _DiameterSection(
        title: '$prefix - ${localization.diam_major}',
        diameter: info.diameter,
        dEs: info.dEs,
        dEi: info.dEi,
        min: info.majorDiamMin,
        avg: info.majorDiamAvg,
        max: info.majorDiamMax,
      );
    }
  }

  // Метод для создания дополнительных секций диаметров
  List<Widget> _buildAdditionalSections(
      String prefix, bool isFemale, GeneratedLocalization localization) {
    List<Widget> sections = <Widget>[];

    if (isFemale) {
      sections.add(_DiameterSection(
        title: '$prefix - ${localization.diam_major}',
        diameter: info.diameter,
        dEs: info.dEs,
        dEi: info.dEi,
        min: info.majorDiamMin,
        avg: info.majorDiamAvg,
        max: info.majorDiamMax,
      ));
    } else {
      sections.add(_DiameterSection(
        title: '${prefix}1 - ${localization.diam_minor}',
        diameter: info.minorDiamD1,
        dEs: info.d1Es,
        dEi: info.d1Ei,
        min: info.minorDiamMin,
        avg: info.minorDiamAvg,
        max: info.minorDiamMax,
      ));

      sections.add(const SizedBox(height: 10.0));

      sections.add(_DiameterSection(
        title: localization.d3_label,
        diameter: info.minorDiamD3,
        dEs: info.d3Es,
        dEi: info.d3Ei,
        min: info.minorDiamMinD3,
        avg: info.minorDiamAvgD3,
        max: info.minorDiamMaxD3,
      ));
    }

    return sections;
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
    final GeneratedLocalization localization = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Заголовок секции
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
                diameter: diameter,
                dEs: dEs,
                dEi: dEi,
              ),
            ],
          ),
        ),
        // Отображение min, avg, max, если они заданы
        if (min != null && avg != null && max != null) ...<Widget>[
          const SizedBox(height: 6.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
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
    final bool hasDEs = dEs != null && dEs != 0;
    final bool hasDEi = dEi != null && dEi != 0;

    // Метод для форматирования значения с префиксом
    String formatValue(num? value) {
      if (value == null) return '';
      return value > 0 ? '+${value.toString()}' : value.toString();
    }

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
                  formatValue(dEs),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              if (hasDEi)
                Text(
                  formatValue(dEi),
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
      children: <Widget>[
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
