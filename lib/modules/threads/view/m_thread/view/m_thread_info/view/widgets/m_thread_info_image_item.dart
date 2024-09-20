import 'dart:math';

import 'package:flutter/material.dart';

class MThreadInfoImageItem extends StatelessWidget {
  const MThreadInfoImageItem({
    Key? key,
    required this.posX,
    required this.posY,
    required this.angle,
    required this.minSizeImage,
    required this.text,
    required this.style,
  }) : super(key: key);

  final double posX;
  final double posY;
  final double angle;
  final double minSizeImage;
  final String text;
  final TextStyle style;
  //===============
  @override
  Widget build(BuildContext context) => Transform.translate(
        offset:
            Offset((posX / 100) * minSizeImage, (posY / 100) * minSizeImage),
        child: Transform.rotate(
          angle: angle * pi / 180,
          child: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Text(
              text,
              textAlign: TextAlign.start,
              style: style,
            ),
          ),
        ),
      );
}
