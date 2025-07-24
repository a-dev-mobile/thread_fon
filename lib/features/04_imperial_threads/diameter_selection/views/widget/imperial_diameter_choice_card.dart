import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/04_imperial_threads/diameter_selection/models/imperial_diameter_model.dart';

class ImperialDiameterChoiceCard extends StatelessWidget {
  final Formatted formatted;
  final String series;
  final String tpi;
  final String diameter;
  final VoidCallback onTap;

  const ImperialDiameterChoiceCard({
    required this.formatted,
    required this.series,
    required this.tpi,
    required this.diameter,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return MyCard(
      onTap: onTap,
      child: ListTile(
        trailing: Text(
          series,
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        title: Text(
          formatted.fractional,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(formatted.decimal, style: theme.textTheme.titleMedium),
      ),
    );
  }
}

/*
Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$series Series',
            style: theme.textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'TPI: $tpi',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Fractional: ${formatted.fractional}',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            'Decimal: ${formatted.decimal}',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            'Diameter: $diameter"',
            style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
        ],
      )

 */
