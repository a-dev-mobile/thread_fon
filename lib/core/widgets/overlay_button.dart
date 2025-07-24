// overlay_button.dart
import 'package:flutter/material.dart';

class OverlayButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const OverlayButton({required this.icon, required this.onPressed, super.key});

  // Method to get button background color based on theme
  Color _getButtonBackgroundColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.black.withOpacity(0.5)
        : Colors.white.withOpacity(0.7);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getButtonBackgroundColor(context),
        shape: BoxShape.circle,
      ),
      child: IconButton(icon: Icon(icon), onPressed: onPressed, iconSize: 20.0),
    );
  }
}
