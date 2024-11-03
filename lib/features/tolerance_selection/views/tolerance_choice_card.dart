// widgets/tolerance_choice_card.dart

import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/choice_card.dart';
import 'package:threadfon/features/tolerance_selection/models/tolerance_model.dart';

class ToleranceChoiceCard extends StatelessWidget {
  final ToleranceModel tolerance;
  final VoidCallback onTap;

  const ToleranceChoiceCard({
    required this.tolerance,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceCard(
      onTap: onTap,
      child: Text(
        tolerance.info,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
