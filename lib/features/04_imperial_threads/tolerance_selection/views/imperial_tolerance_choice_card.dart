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
    final bool isEqual =
        tolerance.formatted.fractional == tolerance.formatted.decimal;

    return MyCard(
      onTap: onTap,
      child: ListTile(
        title: Text(
          tolerance.formatted.fractional,
          textAlign: TextAlign.center,
          style: Theme.of(
            context,
          ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        subtitle: isEqual
            ? null
            : Text(
                tolerance.formatted.decimal,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium,
              ),
      ),
    );
  }
}
