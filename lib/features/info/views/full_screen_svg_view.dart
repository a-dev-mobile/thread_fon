// Создайте новый файл full_screen_svg_view.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/services.dart';

class FullScreenSvgView extends StatefulWidget {
  final String svgData;


  const FullScreenSvgView({
    Key? key,
    required this.svgData,

  }) : super(key: key);

  @override
  _FullScreenSvgViewState createState() => _FullScreenSvgViewState();
}

class _FullScreenSvgViewState extends State<FullScreenSvgView> {
  @override
  void initState() {
    super.initState();
    // Lock orientation to landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Unlock orientation
    SystemChrome.setPreferredOrientations(DeviceOrientation.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PhotoView.customChild(
            enableRotation: false,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),
            child: SvgPicture.string(
              widget.svgData,
              fit: BoxFit.contain,
            ),
          ),
          // Back button
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.0,
            left: 8.0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
