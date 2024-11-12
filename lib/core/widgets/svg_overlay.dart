// svg_overlay.dart
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'overlay_button.dart';

class SvgOverlay extends StatelessWidget {
  final String svgData;
  final VoidCallback onClose;
  final VoidCallback onExpand;
  final double overlayHeight;
  final double svgAspectRatio;
  final double svgWidth;
  final double svgHeight;

  const SvgOverlay({
    Key? key,
    required this.svgData,
    required this.onClose,
    required this.onExpand,
    required this.overlayHeight,
    required this.svgAspectRatio,
    required this.svgWidth,
    required this.svgHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: overlayHeight,
      child: ClipRRect(
   
        child: Card.outlined(
               margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            
             
            ),
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: svgAspectRatio,
                  child: PhotoView.customChild(
                    childSize: Size(svgWidth, svgHeight),
                    minScale: PhotoViewComputedScale.contained * 1,
                    maxScale: PhotoViewComputedScale.covered * 3,
                    initialScale: PhotoViewComputedScale.contained,
                    enableRotation: false,
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: SvgPicture.string(
                      svgData,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                // Expand Button
                Positioned(
                  left: 0.0, // Добавлено небольшое смещение для лучшего расположения
                  top: 0.0,
                  child: OverlayButton(
                    icon: FontAwesomeIcons.expand,
                    onPressed: onExpand,
                  ),
                ),
                // Close Button
                Positioned(
                  right: 0.0, // Добавлено небольшое смещение для лучшего расположения
                  top: 0.0,
                  child: OverlayButton(
                    icon: Icons.close,
                    onPressed: onClose,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
