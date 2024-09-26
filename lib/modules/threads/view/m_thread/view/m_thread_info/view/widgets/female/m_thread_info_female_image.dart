import 'dart:math';

import 'package:flutter/material.dart';
// Package imports:

import 'package:threadfon/config/styles/app_text_style.dart';
import 'package:threadfon/core/utils/app_utils.dart';
import 'package:threadfon/modules/threads/view/m_thread/view/m_thread_info/view/widgets/m_thread_info_image_item.dart';

class MThreadInfoFemaleImage extends StatelessWidget {
  const MThreadInfoFemaleImage({
    required this.path,
    required this.pitch,
    required this.depth,
    required this.diamMinor,
    required this.diamMiddle,
    required this.diamMajor,
    required this.diamMinorToleranceTop,
    required this.diamMinorToleranceBottom,
    required this.diamMiddleToleranceTop,
    required this.diamMiddleToleranceBottom,
    required this.diamMajorToleranceTop,
    required this.diamMajorToleranceBottom,
    super.key,
  });
  final String path;
  final String pitch;
  final String depth;
  final String diamMinor;
  final String diamMinorToleranceTop;
  final String diamMinorToleranceBottom;
  final String diamMiddle;
  final String diamMiddleToleranceTop;
  final String diamMiddleToleranceBottom;
  final String diamMajor;
  final String diamMajorToleranceTop;
  final String diamMajorToleranceBottom;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 0.4,
        width: 1,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final minSize = min(constraints.maxWidth, constraints.maxHeight);

            return Stack(
              alignment: Alignment.center,
              children: [
                SizedBox.expand(
                  child: Image(
                    fit: BoxFit.contain,
                    // color: Theme.of(context).textTheme.bodyText1!.color,
                    image: AssetImage(path),
                  ),
                ),
                //all widget text in image

                MThreadInfoImageItem(
                  angle: 0,
                  posX: -28.5,
                  posY: 4.697,
                  minSizeImage: minSize,
                  text: depth,
                  style: AppTextStyle.H3_REGULAR(context: context),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -4.539,
                  posY: -27,
                  minSizeImage: minSize,
                  text: pitch,
                  style: AppTextStyle.H3_REGULAR(context: context),
                ),

                // minor
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -35,
                  posY: 25,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMinorToleranceTop),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -45,
                  posY: 30,
                  minSizeImage: minSize,
                  text: 'Ø$diamMinor',
                  style: AppTextStyle.CAPTION(context: context),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -35,
                  posY: 35,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMinorToleranceBottom),
                ),

                // pitch diam
                MThreadInfoImageItem(
                  angle: 0,
                  posX: 5,
                  posY: 20,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMiddleToleranceTop),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -5,
                  posY: 25,
                  minSizeImage: minSize,
                  text: 'Ø$diamMiddle',
                  style: AppTextStyle.CAPTION(context: context),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: 5,
                  posY: 30,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMiddleToleranceBottom),
                ),

                // major diam
                MThreadInfoImageItem(
                  angle: 0,
                  posX: 40,
                  posY: 15,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMajorToleranceTop),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: 30,
                  posY: 20,
                  minSizeImage: minSize,
                  text: 'Ø$diamMajor',
                  style: AppTextStyle.CAPTION(context: context),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: 40,
                  posY: 25,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMajorToleranceBottom),
                ),
              ],
            );
          },
        ),
      );

  String _updateTolerance(String value) {
    if (AppUtilsParse.stringToDouble(value) == 0) {
      return '';
    }

    if (AppUtilsParse.stringToDouble(value) > 0) {
      return '+$value';
    }

    return value;
  }
}
