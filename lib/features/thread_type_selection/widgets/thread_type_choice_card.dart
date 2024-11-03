import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threadfon/core/widgets/choice_card.dart';

class ThreadTypeChoiceCard extends StatelessWidget {
  final String svgAssetPath;
  final String label;
  final VoidCallback onTap;

  const ThreadTypeChoiceCard({
    required this.svgAssetPath,
    required this.label,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChoiceCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAssetPath,
            height: 80,
            width: 80,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 12),
          Text(
            label.toUpperCase(),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
