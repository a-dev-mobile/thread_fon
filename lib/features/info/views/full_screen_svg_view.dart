// Создайте новый файл full_screen_svg_view.dart
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:flutter/services.dart';

class FullScreenSvgView extends StatefulWidget {
  final String svgData;
  final String designation; // Добавлено поле designation

  const FullScreenSvgView({
    Key? key,
    required this.svgData,
    required this.designation, // Обновлен конструктор
  }) : super(key: key);

  @override
  _FullScreenSvgViewState createState() => _FullScreenSvgViewState();
}

class _FullScreenSvgViewState extends State<FullScreenSvgView> {
  @override
  void initState() {
    super.initState();
    // Устанавливаем горизонтальную ориентацию
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    // Возвращаем ориентацию к портретной
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(

        children: [
          PhotoView.customChild(
            enableRotation: true,
            backgroundDecoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
            ),

            child: SvgPicture.string(
              widget.svgData,
              color: isDark ? Colors.white : null,
              fit: BoxFit.contain,
            ),
          ),
          // Кнопка "Назад" в верхнем левом углу
          Positioned(
            top: MediaQuery.of(context).padding.top + 8.0,
            left: 8.0,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          // Positioning designation vertically on the left, centered
          Positioned(
            left: -40,
            top: 0,
            bottom: 0,
            child: Center(
              child: Transform.rotate(
                angle: -math.pi / 2, // Rotate 90 degrees counterclockwise
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    widget.designation,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
