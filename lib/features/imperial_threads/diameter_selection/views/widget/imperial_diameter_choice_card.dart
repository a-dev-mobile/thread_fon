import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';

class ImperialDiameterChoiceCard extends StatelessWidget {
  final String info;
  final VoidCallback onTap;

  const ImperialDiameterChoiceCard({
    required this.info,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
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
