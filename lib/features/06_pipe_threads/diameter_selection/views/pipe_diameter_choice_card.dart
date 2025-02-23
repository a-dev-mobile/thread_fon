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
          model.fractional,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
    );
  }
}
