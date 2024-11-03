import 'package:flutter/material.dart';

class ChoiceCard extends StatelessWidget {
  final Widget child;
  final VoidCallback onTap;

  const ChoiceCard({
    required this.child,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = Theme.of(context).cardColor;

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 3,
      margin: const EdgeInsets.all(8),
      color: cardColor,
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: child,
          ),
        ),
      ),
    );
  }
}
