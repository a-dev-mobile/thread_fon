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
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            border: Border(
              top: BorderSide(
          color: Theme.of(context).dividerColor,
          width: 1.0,
              ),
            ),
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
          left: 0.0,
          top: 0.0,
          child: OverlayButton(
            icon: FontAwesomeIcons.expand,
            onPressed: onExpand,
          ),
              ),
              // Close Button
              Positioned(
          right: 0.0,
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
    );
  }
}
