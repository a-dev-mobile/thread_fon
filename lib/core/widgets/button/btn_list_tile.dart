import 'package:flutter/material.dart';

import '../../../config/styles/app_text_style.dart';

class BtnListTile extends StatelessWidget {
  const BtnListTile({
    Key? key,
    required this.onTap,
    this.leading,
    required this.text,
    this.trailing,
  }) : super(key: key);

  final Function() onTap;
  final Widget? leading;
  final Widget? trailing;
  final String text;

  @override
  Widget build(BuildContext context) => ListTile(
        trailing: trailing,
        leading: leading,
        title: Text(text, style: AppTextStyle.BODY_SEMI_BOLD()),
        onTap: onTap,
      );
}
