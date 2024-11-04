import 'package:flutter/material.dart';
import 'package:threadfon/features/info/models/info_model.dart';
import 'package:threadfon/localization/l10n.dart';

class InfoDisplayCard extends StatelessWidget {
  final InfoModel info;
  final VoidCallback onTap;

  const InfoDisplayCard({
    required this.info,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Получение локализованных строк, если необходимо
    final localization = context.l10n;

    return Card(
      margin: const EdgeInsets.all(12.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Заголовок карточки
              Text(
                localization.threads_info, // Предполагается наличие локализации
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16.0),

              // Основная информация

              _buildInfoRow(context, localization.diameter, info.diameter.toString()),
              _buildInfoRow(context, localization.pitch, info.pitch.toString()),
              _buildInfoRow(context, localization.tolerance, info.tolerance),
              _buildInfoRow(context, localization.type_pitch, info.typePitch.toString()),
              _buildInfoRow(context, localization.thread_depth, info.threadDepth.toString()),

              const Divider(height: 32.0),

              // Диаметры
              Text(
                localization.diameters, // Заголовок секции
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8.0),
              _buildInfoRow(context, localization.major_diam_min, info.majorDiamMin.toString()),
              _buildInfoRow(context, localization.major_diam_avg, info.majorDiamAvg.toString()),
              _buildInfoRow(context, localization.major_diam_max, info.majorDiamMax.toString()),
              _buildInfoRow(context, localization.pitch_diam_d2, info.pitchDiamD2.toString()),
              _buildInfoRow(context, localization.pitch_diam_min, info.pitchDiamMin.toString()),
              _buildInfoRow(context, localization.pitch_diam_avg, info.pitchDiamAvg.toString()),
              _buildInfoRow(context, localization.pitch_diam_max, info.pitchDiamMax.toString()),
              _buildInfoRow(context, localization.minor_diam_min, info.minorDiamMin.toString()),
              _buildInfoRow(context, localization.minor_diam_avg, info.minorDiamAvg.toString()),
              _buildInfoRow(context, localization.minor_diam_max, info.minorDiamMax.toString()),
              _buildInfoRow(context, localization.minor_diam_d1, info.minorDiamD1.toString()),
              _buildInfoRow(context, localization.minor_diam_d3, info.minorDiamD3.toString()),

              const Divider(height: 32.0),

              // Дополнительная информация
              _buildInfoRow(context, localization.h, info.h.toString()),
              _buildInfoRow(context, localization.d_es, info.dEs.toString()),
              _buildInfoRow(context, localization.d_ei, info.dEi?.toString() ),
              _buildInfoRow(context, localization.d1_es, info.d1Es?.toString()),
              _buildInfoRow(context, localization.d1_ei, info.d1Ei?.toString()),
              _buildInfoRow(context, localization.d2_es, info.d2Es?.toString() ),
              _buildInfoRow(context, localization.d2_ei, info.d2Ei?.toString() ),
            ],
          ),
        ),
      ),
    );
  }

  // Вспомогательный метод для создания строк информации
  Widget _buildInfoRow(BuildContext context, String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          // Метка
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ),
          // Значение
          Expanded(
            flex: 5,
            child: Text(
              value??"-",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
