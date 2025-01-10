// widgets/tolerance_choice_card.dart

import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/04_imperial_threads/tolerance_selection/models/imperial_tolerance_model.dart';

class ImperialToleranceChoiceCard extends StatelessWidget {
  final ImperialToleranceItem tolerance;
  final VoidCallback onTap;

  const ImperialToleranceChoiceCard({
    required this.tolerance,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return MyCard(
      onTap: onTap,
      child: ListTile(
        title: Text(
          tolerance.formatted.fractional,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          tolerance.formatted.decimal,
          style: theme.textTheme.titleMedium,
        ),
      ),
    );
  }
}
