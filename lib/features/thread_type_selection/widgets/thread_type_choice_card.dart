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
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChoiceCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset(svgAssetPath),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              label.toUpperCase(),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
