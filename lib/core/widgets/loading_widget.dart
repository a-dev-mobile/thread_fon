import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:threadfon/localization/l10n_extension.dart';

class LoadingWidget extends StatelessWidget {
  final bool isBlurred;

  const LoadingWidget({super.key, this.isBlurred = false});

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Optional loading indicator
          // const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            context.l10n.loadingMessage,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );

    return SizedBox.expand(
      child: isBlurred
          ? BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                color: Colors.black.withOpacity(0.2),
                child: content,
              ),
            )
          : content,
    );
  }
}
