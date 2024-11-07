import 'package:flutter/material.dart';
import 'package:threadfon/core/utils/double_extension.dart';
import 'package:threadfon/core/widgets/choice_card.dart';
import 'package:threadfon/features/info/models/info_model.dart';
import 'package:threadfon/localization/generated/l10n.dart';
import 'package:threadfon/localization/l10n.dart';

class InfoDiametersParameters extends StatelessWidget {
  final InfoModel info;

  const InfoDiametersParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Получение локализованных строк, если необходимо
    final localization = context.l10n;

    return ChoiceCard(
      onTap: null,
      child: Column(
        children: [
          // Диаметры
          Text(
            localization.diam_major, // Заголовок секции
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localization.tolerance, // Метка
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              _buildDiameterItem(context, info.diameter, info.dEs, info.dEi),
            ],
          ),



          
          // _buildDiameterSection(context, localization, info),

              _buildDiameterItem(context, info.diameter, info.dEs, info.dEi),
          const Divider(height: 32.0),

          // Дополнительная информация
          Text(
            localization.additional_info,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8.0),
          _buildAdditionalInfo(context, localization, info),
        ],
      ),
    );
  }

  Row _buildDiameterItem(BuildContext context, double diameter, double? dEs, double? dEi) {
    return Row(
      children: [
        Text(
          diameter.toPrecisionString(3), 
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Column(
          children: [
            Text(
              dEs?.toPrecisionString(3) ?? '', 
              style: Theme.of(context).textTheme.bodySmall,
            ),
            Text(
              dEi?.toPrecisionString(3) ?? '', 
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        )
      ],
    );
  }

  // Метод для создания секции диаметров с допусками
  Widget _buildDiameterSection(BuildContext context, GeneratedLocalization localization, InfoModel info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGroupedInfoRow(
          context: context,
          label: localization.major_diam,
          value: info.majorDiamAvg.toString(),
          toleranceLabel: localization.major_diam_tolerance,
          toleranceValue: _formatTolerance(info.majorDiamMin, info.majorDiamMax),
        ),
        _buildGroupedInfoRow(
          context: context,
          label: localization.pitch_diam,
          value: info.pitchDiamAvg.toString(),
          toleranceLabel: localization.pitch_diam_tolerance,
          toleranceValue: _formatTolerance(info.pitchDiamMin, info.pitchDiamMax),
        ),
        _buildGroupedInfoRow(
          context: context,
          label: localization.minor_diam,
          value: info.minorDiamAvg.toString(),
          toleranceLabel: localization.minor_diam_tolerance,
          toleranceValue: _formatTolerance(info.minorDiamMin, info.minorDiamMax),
        ),
        // Добавьте другие группы при необходимости
      ],
    );
  }

  // Метод для создания секции дополнительной информации с допусками
  Widget _buildAdditionalInfo(BuildContext context, GeneratedLocalization localization, InfoModel info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildGroupedInfoRow(
          context: context,
          label: localization.d_es,
          value: info.dEs?.toString(),
          toleranceLabel: localization.d_es_tolerance,
          toleranceValue: info.dEs != null ? info.dEs.toString() : '-',
        ),
        _buildGroupedInfoRow(
          context: context,
          label: localization.d_ei,
          value: info.dEi?.toString(),
          toleranceLabel: localization.d_ei_tolerance,
          toleranceValue: info.dEi != null ? info.dEi.toString() : '-',
        ),
        _buildGroupedInfoRow(
          context: context,
          label: localization.d1_es,
          value: info.d1Es?.toString(),
          toleranceLabel: localization.d1_es_tolerance,
          toleranceValue: info.d1Es != null ? info.d1Es.toString() : '-',
        ),
        _buildGroupedInfoRow(
          context: context,
          label: localization.d2_ei,
          value: info.d2Ei?.toString(),
          toleranceLabel: localization.d2_ei_tolerance,
          toleranceValue: info.d2Ei != null ? info.d2Ei.toString() : '-',
        ),
        _buildGroupedInfoRow(
          context: context,
          label: localization.d2_es,
          value: info.d2Es?.toString(),
          toleranceLabel: localization.d2_es_tolerance,
          toleranceValue: info.d2Es != null ? info.d2Es.toString() : '-',
        ),
        // Добавьте другие группы при необходимости
      ],
    );
  }

  // Метод для создания группированной строки с параметром и его допуском
  Widget _buildGroupedInfoRow({
    required BuildContext context,
    required String label,
    required String? value,
    required String toleranceLabel,
    required String? toleranceValue,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Основной параметр
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  '$label:',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  value ?? "-",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
          // Допуск
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 2.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(
                    '$toleranceLabel:',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Text(
                    toleranceValue ?? "-",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[800],
                        ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Метод для форматирования допусков (пример)
  String _formatTolerance(double min, double max) {
    return '$min / $max';
  }

  // Вспомогательный метод для создания строк информации
  Widget _buildInfoRow(BuildContext context, String label, Object? value) {
    String displayValue;

    if (value is double) {
      // Если value - double, форматируем его с точностью 3 знака после запятой
      displayValue = value.toPrecisionString(3);
    } else if (value is String) {
      // Если value - String, используем его как есть
      displayValue = value;
    } else if (value == null) {
      // Если value - null, отображаем дефис
      displayValue = "-";
    } else {
      // Для остальных типов данных вызываем toString()
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Метка
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          // Значение
          Text(
            displayValue,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
