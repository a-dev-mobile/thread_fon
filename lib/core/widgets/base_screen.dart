// lib/core/widgets/base_screen.dart

import 'package:flutter/material.dart';
import 'package:threadfon/features/settings/views/settings_drawer.dart';

class DrawerScreen extends StatelessWidget {
  final Widget body;
  final String title;

  const DrawerScreen({
    super.key,
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const SettingsDrawer(),
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
    );
  }
}
