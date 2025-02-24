// widgets/diameter_choice_card.dart

import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/06_pipe_threads/diameter_selection/models/pipe_diameter_model.dart';

class PipeDiameterChoiceCard extends StatelessWidget {
  final PipeDiameterItem model;
  final VoidCallback onTap;
  final bool isFemale;

  const PipeDiameterChoiceCard({
    required this.model,
    required this.onTap,
    required this.isFemale,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MyCard(
      onTap: onTap,
      child: ListTile(
        title: Text(
          isFemale
              ? model.fractional
              : '${model.fractional} ${model.tolerance}',
          textAlign: TextAlign.center,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          model.decimal,
          textAlign: TextAlign.center,
          style: theme.textTheme.bodyMedium?.copyWith(
              // color: theme.textTheme.caption?.color,
              ),
        ),
      ),
    );
  }
}
