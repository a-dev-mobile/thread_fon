// info_row.dart
import 'package:flutter/material.dart';
import 'package:threadfon/core/utils/double_extension.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final Object? value;

  const InfoRow({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String displayValue;

    if (value is double) {
      displayValue = (value as double).toPrecisionString(3);
    } else if (value is String) {
      displayValue = value as String;
    } else if (value == null) {
      displayValue = "-";
    } else {
      displayValue = value.toString();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          Text(
            displayValue,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
