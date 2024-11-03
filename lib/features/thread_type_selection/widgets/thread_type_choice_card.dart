import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThreadTypeChoiceCard extends StatelessWidget {
  const ThreadTypeChoiceCard({
    required this.svgAssetPath,
    required this.label,
    required this.onTap,
    super.key,
  });

  final String svgAssetPath;
  final String label;
  final VoidCallback onTap;

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
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
