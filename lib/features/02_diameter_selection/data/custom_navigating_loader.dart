import 'package:flutter/material.dart';

class CustomNavigatingLoader extends StatefulWidget {
  const CustomNavigatingLoader({super.key});

  @override
  _CustomNavigatingLoaderState createState() => _CustomNavigatingLoaderState();
}

class _CustomNavigatingLoaderState extends State<CustomNavigatingLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely

    // Define the animation (rotation from 0 to 2π radians)
    _animation =
        Tween<double>(begin: 0, end: 2 * 3.1415926535).animate(_controller);
  }

  @override
  void dispose() {
    // Dispose the controller to free resources
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use AnimatedBuilder to rebuild the widget tree when the animation changes
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.rotate(
            angle: _animation.value,
            child: child,
          );
        },
        child: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(
              Icons.arrow_forward,
              color: Colors.white,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}
