// info_row.dart
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;
  final bool isHaveDividerBottom;

  const InfoRow({
    required this.label,
    required this.value,
    super.key,
    this.isHaveDividerBottom = true,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return const SizedBox.shrink();
    }

    final TextStyle? labelStyle =
        Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
            );
    final TextStyle? valueStyle = Theme.of(context).textTheme.bodyMedium;

    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          // Label
          Expanded(
            child: Text(
              label,
              style: labelStyle,
            ),
          ),
          const SizedBox(width: 8.0), // Отступ между label и value
          // Value
          Text(
            value!,
            style: valueStyle,
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
