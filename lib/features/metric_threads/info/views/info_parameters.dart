import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/metric_threads/info/models/info_model.dart';
import 'package:threadfon/features/metric_threads/info/views/info_row.dart';
import 'package:threadfon/localization/generated/l10n.dart';
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

    // Список параметров для отображения
    final List<_Parameter> parameters = _getParameters(localization, info);

    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: parameters
            .map(
              (param) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: InfoRow(
                  label: param.label,
                  value: param.value.toString(),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  // Метод для получения списка параметров
  List<_Parameter> _getParameters(
      GeneratedLocalization localization, InfoModel info) {
    return [
      _Parameter(
        label: localization.heightOfFundamentalTriangle,
        value: info.h,
      ),
      _Parameter(
        label: localization.workingHeightOfProfile,
        value: info.fiveHDiv8,
      ),
      _Parameter(
        label: localization.crestTruncation,
        value: info.hDiv8,
      ),
      _Parameter(
        label: localization.rootTruncation,
        value: info.hDiv4,
      ),
      _Parameter(
        label: localization.totalTruncation,
        value: info.threeHDiv8,
      ),
      // Дополнительные параметры
      _Parameter(
        label: localization.halfPitch,
        value: info.pitchDiv2,
      ),
      _Parameter(
        label: localization.quarterPitch,
        value: info.pitchDiv4,
      ),
      _Parameter(
        label: localization.eighthPitch,
        value: info.pitchDiv8,
      ),
      _Parameter(
        label: localization.cmin_label,
        value: info.cMin,
      ),
      _Parameter(
        label: localization.cmax_label,
        value: info.cMax,
      ),
      _Parameter(
        label: localization.rmax_label,
        value: info.rMax,
      ),
      _Parameter(
        label: localization.rmin_label,
        value: info.rMin,
      ),
    ];
  }
}

// Вспомогательный класс для хранения параметров
class _Parameter {
  final String label;
  final num? value;

  _Parameter({
    required this.label,
    required this.value,
  });
}
