import 'package:flutter/material.dart';

class ChoiceCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final bool isHeader;

  const ChoiceCard({
    required this.child,
    this.onTap,
    this.isHeader = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (isHeader) {
      // Стиль для заголовков
      return Container(
        width: double.infinity,
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
          child: child,
        ),
      );
    } else {
      // Стиль для кликабельных элементов
      return Card(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        elevation: 2.0,
        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.0),
          splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: child,
          ),
        ),
      );
    }
  }
}
