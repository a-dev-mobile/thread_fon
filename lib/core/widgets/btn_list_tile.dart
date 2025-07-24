import 'package:flutter/material.dart';

class BtnListTile extends StatelessWidget {
  const BtnListTile({
    required this.onTap,
    required this.text,
    super.key,
    this.leading,
    this.trailing,
  });

  final Function() onTap;
  final Widget? leading;
  final Widget? trailing;
  final String text;

  @override
  Widget build(BuildContext context) => ListTile(
    trailing: trailing,
    leading: leading,
    title: Text(text),
    onTap: onTap,
  );
}
