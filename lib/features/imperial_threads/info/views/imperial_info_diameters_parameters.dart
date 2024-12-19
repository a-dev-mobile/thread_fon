import 'package:flutter/material.dart';
import 'package:threadfon/core/constant/enum_thread%20copy.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/imperial_threads/info/models/imperial_info_model.dart';
import 'package:threadfon/features/imperial_threads/info/views/imperial_info_row_max_min.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class ImperialInfoDiametersParameters extends StatelessWidget {
  final ImperialInfoModel info;

  const ImperialInfoDiametersParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localization = context.l10n;
    final isFemale = info.type_.isFemale;
    final prefix = isFemale ? 'D' : 'd';

    // Создаем список виджетов секций диаметров
    final List<Widget> sections = [];

    // Добавляем первую секцию диаметров в зависимости от типа резьбы
    if (info.type_.isMale) {
      sections.add(_DiameterSection(
        title: '$prefix - ${localization.diam_major}',
        diameter: info.major_diameter_basic,
        dEs: info.major_diam_es,
        dEi: info.major_diam_ei,
        min: info.major_diam_min,
        avg: info.major_diameter_avg,
        max: info.major_diam_max,
      ));
    } else {
      sections.add(_DiameterSection(
        title: '${prefix}1 - ${localization.diam_minor}',
        diameter: info.minor_diameter_basic,
        dEs: info.minor_diam_es,
        dEi: info.minor_diam_ei,
        min: info.minor_diameter_min,
        avg: info.minor_diameter_avg,
        max: info.minor_diameter_max,
      ));
    }
// ------------------------------------
// ------------------------------------
// ------------------------------------

    sections.add(const SizedBox(height: 10.0));

    // Добавляем среднюю секцию диаметра
    sections.add(_DiameterSection(
      title: '${prefix}2 - ${localization.diam_middle}',
      diameter: info.pitch_diameter_basic,
      dEs: info.pitch_diameter_es,
      dEi: info.pitch_diameter_ei,
      min: info.pitch_diameter_min,
      avg: info.pitch_diameter_avg,
      max: info.pitch_diameter_max,
    ));
    sections.add(const SizedBox(height: 10.0));

    if (isFemale) {
      sections.add(ImperialInfoRowMaxMin(
        isHaveDividerBottom: false,
        label: '$prefix - ${localization.diam_major}',
        value: info.major_diameter_basic.toString(),
        labelMaxMin: localization.min,
      ));
    } else {
      // sections.add(_DiameterSection(
      //   title: '${prefix}1max - ${localization.minor_diam_max}',
      //   diameter: info.minor_diameter_basic,
      //   dEs: info.minor_diam_es,
      //   dEi: info.minor_diam_ei,
      //   min: info.minor_diameter_min,
      //   avg: info.minor_diameter_avg,
      //   max: info.minor_diameter_max,
      // ));
      sections.add(ImperialInfoRowMaxMin(
        // isHaveDividerBottom: false,
        label: '${prefix}1 - ${localization.diam_minor}',
        value: info.minor_diameter_max.toString(),
        labelMaxMin: localization.max,
      ));
      sections.add(SizedBox(height: 10.0));
    }
// ------------------------------------
// ------------------------------------
// ------------------------------------

    // Добавляем информацию о диаметре отверстия, если она существует
    if (info.type_.isMale) {
      sections.add(ImperialInfoRowMaxMin(
        isHaveDividerBottom: false,
        label: '${prefix}3 - ${localization.minor_diameter_unr}',
        value: info.unr_minor_diameter_max.toString(),
        labelMaxMin: localization.max,
      ));
      // diameterSections.add(const SizedBox(height: 10.0));
    }

    return MyCard(
      onTap: null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: sections,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
    final hasDEs = dEs != null && dEs != 0;
    final hasDEi = dEi != null && dEi != 0;

    // Метод для форматирования значения с префиксом
    String formatValue(num? value) {
      if (value == null) return '';
      return value > 0 ? '+${value.toString()}' : value.toString();
    }

    return Row(
      children: [
        Text(
          diameter.toString(),
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        if (hasDEs || hasDEi) ...[
          const SizedBox(width: 8.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

class _AdditionalImperialInfoItem extends StatelessWidget {
  final String label;
  final num value;

  const _AdditionalImperialInfoItem({
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
