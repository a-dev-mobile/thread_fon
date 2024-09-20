import 'package:flutter/material.dart';

import '../constants/colors.dart';

class MyDivider extends StatelessWidget {
  const MyDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => const Divider(
        height: 0.5,
        endIndent: 16,
        indent: 16,
        color: ConstColor.neutral_grey_400,
      );
}
