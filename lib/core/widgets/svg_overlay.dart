// svg_overlay.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:threadfon/core/constant/enum_status.dart';
import 'package:threadfon/core/widgets/loading_widget.dart';

import 'overlay_button.dart';

class SvgOverlay extends StatelessWidget {
  final String? svgData;
  final EnumStatus svgRequestStatus;
  final String? svgErrorMsg;

  final double overlayHeight;
  final double svgAspectRatio;
  final double svgWidth;
  final double svgHeight;
  final VoidCallback onClose;
  final VoidCallback onExpand;
  final VoidCallback onSwitchSvg;
  final bool showDimensions;

  const SvgOverlay({
    required this.svgData,
    required this.overlayHeight,
    required this.svgAspectRatio,
    required this.svgWidth,
    required this.svgHeight,
    required this.onClose,
    required this.onExpand,
    required this.onSwitchSvg,
    required this.showDimensions,
    required this.svgRequestStatus,
    super.key,
    this.svgErrorMsg,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    switch (svgRequestStatus) {
      case EnumStatus.loading:
        content = const LoadingWidget();
        break;
      case EnumStatus.success:
        content = SvgPicture.string(
          svgData!,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        );
        break;
      case EnumStatus.error:
        content = Center(child: Text(svgErrorMsg ?? 'Error loading SVG'));
        break;
    }
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      height: overlayHeight,
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            borderRadius: const BorderRadius.only(
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
            children: <Widget>[
              // Ensure the SVG content is centered by wrapping it in a Center widget
              Center(
                child: AspectRatio(
                  aspectRatio: svgAspectRatio,
                  child: PhotoView.customChild(
                    childSize: Size(svgWidth, svgHeight),
                    minScale: PhotoViewComputedScale.contained * 0.5,
                    maxScale: PhotoViewComputedScale.covered * 12,
                    initialScale: PhotoViewComputedScale.contained,
                    enableRotation: false,
                    backgroundDecoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: content,
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
              Positioned(
                left: 0.0,
                bottom: 0.0,
                child: OverlayButton(
                  icon: showDimensions ? Icons.layers : Icons.layers_clear,
                  onPressed: onSwitchSvg,
                ),
              ),
              // Close Button
              Positioned(
                right: 0.0,
                top: 0.0,
                child: OverlayButton(icon: Icons.close, onPressed: onClose),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
