import 'dart:math';

import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../config/styles/app_text_style.dart';
import '../../../../../../../../../core/utils/app_utils.dart';
import '../m_thread_info_image_item.dart';

class MThreadInfoMaleImage extends StatelessWidget {
  const MThreadInfoMaleImage({
    Key? key,
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
  }) : super(key: key);
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
        height: 0.4.sh,
        width: 1.sw,
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
                  posX: -33.487,
                  posY: -43.136,
                  minSizeImage: minSize,
                  text: depth,
                  style: AppTextStyle.H3_REGULAR(context: context),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -2.486,
                  posY: -43.136,
                  minSizeImage: minSize,
                  text: pitch,
                  style: AppTextStyle.H3_REGULAR(context: context),
                ),

                //
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -30,
                  posY: 25,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMajorToleranceTop),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -40,
                  posY: 30,
                  minSizeImage: minSize,
                  text: 'Ø$diamMajor',
                  style: AppTextStyle.CAPTION(context: context),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: -30,
                  posY: 35,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMajorToleranceBottom),
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

                // MAJOR
                MThreadInfoImageItem(
                  angle: 0,
                  posX: 40,
                  posY: 20,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMinorToleranceTop),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: 30,
                  posY: 25,
                  minSizeImage: minSize,
                  text: 'Ø$diamMinor',
                  style: AppTextStyle.CAPTION(context: context),
                ),
                MThreadInfoImageItem(
                  angle: 0,
                  posX: 40,
                  posY: 30,
                  minSizeImage: minSize,
                  style: AppTextStyle.LABEL_REGULAR(context: context),
                  text: _updateTolerance(diamMiddleToleranceBottom),
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
