// info_row.dart
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          if (value != null)
            Text(
              value!,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
        ],
      ),
    );
  }
}
