import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/info_row.dart';
import 'package:threadfon/core/widgets/my_card.dart';

import 'package:threadfon/features/05_trapezoidal_threads/info/models/trapezoidal_info_model.dart';

class TrapezoidalAdditionalInfo extends StatelessWidget {
  final List<AdditionalInfo> list;

  const TrapezoidalAdditionalInfo({
    required this.list,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Create widgets for parameters first
    final List<Widget> paramWidgets = <Widget>[];

    // Add additional info items if they exist
    if (list.isNotEmpty) {
      // Add divider if we had previous parameters
      if (paramWidgets.isNotEmpty) {
        paramWidgets.add(const Divider());
      }

      // Add each additional info item
      for (int i = 0; i < list.length; i++) {
        final AdditionalInfo item = list[i];
        paramWidgets.add(
          InfoRow(
            label: item.name,
            value: item.value,
            isHaveDividerBottom: i < list.length - 1,
          ),
        );
      }
    }

    return MyCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: paramWidgets,
      ),
    );
  }
}
