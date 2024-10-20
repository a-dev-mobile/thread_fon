// import 'dart:math';

// import 'package:flutter/material.dart';
// // Package imports:

// import 'package:threadfon/src/common/styles/app_text_styles_extension.dart';
// import 'package:threadfon/src/common/util/app_utils.dart';

// class MThreadInfoMaleImage extends StatelessWidget {
//   const MThreadInfoMaleImage({
//     required this.path,
//     required this.pitch,
//     required this.depth,
//     required this.diamMinor,
//     required this.diamMiddle,
//     required this.diamMajor,
//     required this.diamMinorToleranceTop,
//     required this.diamMinorToleranceBottom,
//     required this.diamMiddleToleranceTop,
//     required this.diamMiddleToleranceBottom,
//     required this.diamMajorToleranceTop,
//     required this.diamMajorToleranceBottom,
//     super.key,
//   });
//   final String path;
//   final String pitch;
//   final String depth;
//   final String diamMinor;
//   final String diamMinorToleranceTop;
//   final String diamMinorToleranceBottom;
//   final String diamMiddle;
//   final String diamMiddleToleranceTop;
//   final String diamMiddleToleranceBottom;
//   final String diamMajor;
//   final String diamMajorToleranceTop;
//   final String diamMajorToleranceBottom;
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return SizedBox(
//       height: 0.4 * size.height,
//       width: size.width,
//       child: LayoutBuilder(
//         builder: (context, constraints) {
//           final minSize = min(constraints.maxWidth, constraints.maxHeight);

//           return Stack(
//             alignment: Alignment.center,
//             children: [
//               SizedBox.expand(
//                 child: Image(
//                   color: Theme.of(context).textTheme.bodyMedium!.color,
//                   fit: BoxFit.contain,
//                   image: AssetImage(path),
//                 ),
//               ),
//               //all widget text in image

//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: -33.487,
//                 posY: -43.136,
//                 minSizeImage: minSize,
//                 text: depth,
//                 style: context.textStyle.headlineSmall,
//               ),
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: -2.486,
//                 posY: -43.136,
//                 minSizeImage: minSize,
//                 text: pitch,
//                 style: context.textStyle.headlineSmall,
//               ),

//               //
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: -30,
//                 posY: 25,
//                 minSizeImage: minSize,
//                 style: context.textStyle.headlineSmall,
//                 text: _updateTolerance(diamMajorToleranceTop),
//               ),
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: -40,
//                 posY: 35,
//                 minSizeImage: minSize,
//                 text: 'Ø$diamMajor',
//                 style: context.textStyle.headlineSmall,
//               ),
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: -30,
//                 posY: 40,
//                 minSizeImage: minSize,
//                 style: context.textStyle.headlineSmall,
//                 text: _updateTolerance(diamMajorToleranceBottom),
//               ),

//               // pitch diam
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: 5,
//                 posY: 20,
//                 minSizeImage: minSize,
//                 style: context.textStyle.headlineSmall,
//                 text: _updateTolerance(diamMiddleToleranceTop),
//               ),
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: -5,
//                 posY: 28,
//                 minSizeImage: minSize,
//                 text: 'Ø$diamMiddle',
//                 style: context.textStyle.headlineSmall,
//               ),
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: 5,
//                 posY: 33,
//                 minSizeImage: minSize,
//                 style: context.textStyle.headlineSmall,
//                 text: _updateTolerance(diamMiddleToleranceBottom),
//               ),

//               // MAJOR
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: 40,
//                 posY: 20,
//                 minSizeImage: minSize,
//                 style: context.textStyle.headlineSmall,
//                 text: _updateTolerance(diamMinorToleranceTop),
//               ),
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: 30,
//                 posY: 22,
//                 minSizeImage: minSize,
//                 text: 'Ø$diamMinor',
//                 style: context.textStyle.headlineSmall,
//               ),
//               MThreadInfoImageItem(
//                 angle: 0,
//                 posX: 40,
//                 posY: 27,
//                 minSizeImage: minSize,
//                 style: context.textStyle.headlineSmall,
//                 text: _updateTolerance(diamMiddleToleranceBottom),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }

//   String _updateTolerance(String value) {
//     if (AppUtilsParse.stringToDouble(value) == 0) {
//       return '';
//     }

//     if (AppUtilsParse.stringToDouble(value) > 0) {
//       return '+$value';
//     }

//     return value;
//   }
// }
