import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:threadfon/core/widgets/my_card.dart';

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
    // Получаем текущую тему
    final theme = Theme.of(context);
    // Определяем цвет для SVG в зависимости от темы
    final svgColor = theme.brightness == Brightness.dark
        ? theme.colorScheme.inverseSurface // Цвет для тёмной темы
        : theme.colorScheme.primary; // Цвет для светлой темы

    return MyCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgAssetPath,
            // Применяем цвет к SVG
            color: svgColor,
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
