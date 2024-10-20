// import 'dart:math';

// import 'package:flutter/material.dart';
// // Package imports:

// import 'package:threadfon/src/common/styles/app_text_styles_extension.dart';
// import 'package:threadfon/src/common/util/app_utils.dart';
// import 'package:threadfon/src/features/m_thread_info/view/widgets/m_thread_info_image_item.dart';

// class MThreadInfoFemaleImage extends StatelessWidget {
//   const MThreadInfoFemaleImage({
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
//   Widget build(BuildContext context) => SizedBox(
//         height: 0.4,
//         width: 1,
//         child: LayoutBuilder(
//           builder: (context, constraints) {
//             final minSize = min(constraints.maxWidth, constraints.maxHeight);

//             return Stack(
//               alignment: Alignment.center,
//               children: [
//                 SizedBox.expand(
//                   child: Image(
//                     fit: BoxFit.contain,
//                     // color: Theme.of(context).textTheme.bodyText1!.color,
//                     image: AssetImage(path),
//                   ),
//                 ),
//                 //all widget text in image

//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: -28.5,
//                   posY: 4.697,
//                   minSizeImage: minSize,
//                   text: depth,
//                   style: context.textStyle.headlineSmall,
//                 ),
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: -4.539,
//                   posY: -27,
//                   minSizeImage: minSize,
//                   text: pitch,
//                   style: context.textStyle.headlineSmall,
//                 ),

//                 // minor
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: -35,
//                   posY: 25,
//                   minSizeImage: minSize,
//                   style: context.textStyle.headlineSmall,
//                   text: _updateTolerance(diamMinorToleranceTop),
//                 ),
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: -45,
//                   posY: 30,
//                   minSizeImage: minSize,
//                   text: 'Ø$diamMinor',
//                   style: context.textStyle.headlineSmall,
//                 ),
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: -35,
//                   posY: 35,
//                   minSizeImage: minSize,
//                   style: context.textStyle.headlineSmall,
//                   text: _updateTolerance(diamMinorToleranceBottom),
//                 ),

//                 // pitch diam
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: 5,
//                   posY: 20,
//                   minSizeImage: minSize,
//                   style: context.textStyle.headlineSmall,
//                   text: _updateTolerance(diamMiddleToleranceTop),
//                 ),
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: -5,
//                   posY: 25,
//                   minSizeImage: minSize,
//                   text: 'Ø$diamMiddle',
//                   style: context.textStyle.headlineSmall,
//                 ),
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: 5,
//                   posY: 30,
//                   minSizeImage: minSize,
//                   style: context.textStyle.headlineSmall,
//                   text: _updateTolerance(diamMiddleToleranceBottom),
//                 ),

//                 // major diam
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: 40,
//                   posY: 15,
//                   minSizeImage: minSize,
//                   style: context.textStyle.headlineSmall,
//                   text: _updateTolerance(diamMajorToleranceTop),
//                 ),
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: 30,
//                   posY: 20,
//                   minSizeImage: minSize,
//                   text: 'Ø$diamMajor',
//                   style: context.textStyle.headlineSmall,
//                 ),
//                 MThreadInfoImageItem(
//                   angle: 0,
//                   posX: 40,
//                   posY: 25,
//                   minSizeImage: minSize,
//                   style: context.textStyle.headlineSmall,
//                   text: _updateTolerance(diamMajorToleranceBottom),
//                 ),
//               ],
//             );
//           },
//         ),
//       );

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
