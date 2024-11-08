import 'package:flutter/material.dart';
import 'package:threadfon/core/utils/double_extension.dart';
import 'package:threadfon/core/widgets/choice_card.dart';
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

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                info.majorDiamMin.toPrecisionString(3),
              ),
              Text(
                info.majorDiamAvg.toPrecisionString(3),
              ),
              Text(
                info.majorDiamMax.toPrecisionString(3),
              ),
            ],
          ),

          Divider(),
          Text(
            localization.diam_middle, // Заголовок секции
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localization.tolerance,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              _buildDiameterItem(context, info.pitchDiamD2, info.d2Es, info.d2Ei),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                info.pitchDiamMin.toPrecisionString(3),
              ),
              Text(
                info.pitchDiamAvg.toPrecisionString(3),
              ),
              Text(
                info.pitchDiamMax.toPrecisionString(3),
              ),
            ],
          ),
          // ============================
          Divider(),
          Text(
            localization.diam_minor, // Заголовок секции
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localization.tolerance,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              _buildDiameterItem(context, info.minorDiamD1, info.d1Es, info.d1Ei),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                info.minorDiamMin.toPrecisionString(3),
              ),
              Text(
                info.minorDiamAvg.toPrecisionString(3),
              ),
              Text(
                info.minorDiamMax.toPrecisionString(3),
              ),
            ],
          ),

          Divider(),

          const Divider(height: 32.0),

          // Дополнительная информация
          Text(
            localization.additional_info,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8.0),
          if (info.threadType == EnumThreadType.male)
            _itemAddInfo(context, 'Внутренний диаметр резьбы по дну впадины (d3)', info.minorDiamD3),

      
        ],
      ),
    );
  }

  Row _itemAddInfo(BuildContext context, String label, double value) {
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
        _buildDiameterItem(context, value),
      ],
    );
  }

  Row _buildDiameterItem(BuildContext context, double diameter, [double? dEs, double? dEi]) {
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




}
