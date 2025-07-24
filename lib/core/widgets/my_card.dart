import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  const MyCard({required this.child, this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDark = theme.brightness == Brightness.dark;

    return Card(
      elevation: isDark ? 4.0 : 1.0,
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: isDark
              ? theme.colorScheme.surfaceContainerHighest.withOpacity(0.2)
              : theme.colorScheme.outline.withOpacity(0.2),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Padding(padding: const EdgeInsets.all(16.0), child: child),
      ),
    );
  }
}
