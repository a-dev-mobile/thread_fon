import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;


  const MyCard({
    required this.child,
    this.onTap,

    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
    );
  }
}
