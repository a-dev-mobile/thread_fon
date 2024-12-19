// info_row.dart
import 'package:flutter/material.dart';

class ImperialInfoRowMaxMin extends StatelessWidget {
  final String label;
  final String? value;
  final String labelMaxMin;
  final bool isHaveDividerBottom;
  const ImperialInfoRowMaxMin({
    super.key,
    required this.label,
    required this.value,
    this.isHaveDividerBottom = true,
    required this.labelMaxMin,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null) {
      return const SizedBox.shrink();
    }

    final labelStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w600,
        );
    final valueStyle = Theme.of(context).textTheme.bodyMedium;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: isHaveDividerBottom
          ? BoxDecoration(
              border: const Border(
                bottom: BorderSide(
                  color: Colors.grey,
                  width: 0.2,
                ),
              ),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Label
          Expanded(
            child: Text(
              label,
              style: labelStyle,
            ),
          ),
          const SizedBox(width: 8.0), // Отступ между label и value
          // Value
          Column(
            children: [
              Text(
                labelMaxMin,
                style: valueStyle,
                
              ),
              Text(
                value!,
                style: valueStyle,
          
              ),
            ],
          ),
        ],
      ),
    );
  }
}
