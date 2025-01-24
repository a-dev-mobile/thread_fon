// widgets/tolerance_choice_card.dart

import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';

import 'package:threadfon/features/05_trapezoidal_threads/tolerance_selection/models/trapezoidal_tolerance_model.dart';

class TrapezoidalToleranceChoiceCard extends StatelessWidget {
  final TrapezoidalToleranceItem tolerance;
  final VoidCallback onTap;

  const TrapezoidalToleranceChoiceCard({
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
          tolerance.formatted,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
