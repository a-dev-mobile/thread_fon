import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/choice_card.dart';

class InfoChoiceCard extends StatelessWidget {
  final String info;
  final VoidCallback onTap;

  const InfoChoiceCard({
    required this.info,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceCard(
      onTap: onTap,
      child: Text(
        info,
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
