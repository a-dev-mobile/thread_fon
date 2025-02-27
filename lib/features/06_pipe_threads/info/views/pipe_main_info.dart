import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/info_row.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/06_pipe_threads/info/models/pipe_info_model.dart';


class PipeInfoMainParameters extends StatelessWidget {
  final PipeInfoModel info;

  const PipeInfoMainParameters({
    required this.info,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      child: Column(
        children: <Widget>[
          Text(
            info.designation1,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            '(${info.designation2})',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(
            info.description,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8.0),
          Text(
            info.unit,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16.0),
          const Divider(),
          ...info.main_info.map((MainInfo item) {
            return InfoRow(
              label: item.name,
              value: item.value,
              isHaveDividerBottom: item != info.main_info.last,
            );
          }),
        ],
      ),
    );
  }
}
