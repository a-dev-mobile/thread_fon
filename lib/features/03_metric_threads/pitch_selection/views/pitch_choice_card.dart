import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/my_card.dart';
import 'package:threadfon/features/03_metric_threads/pitch_selection/models/pitch_model.dart';

class PitchChoiceCard extends StatelessWidget {
  final PitchModel pitch;
  final VoidCallback? onTap;

  const PitchChoiceCard({
    required this.pitch,
    this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return pitch.enumPitchDataType == EnumPitchDataType.header
        ? Text(
            pitch.info,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(),
          )
        : MyCard(
            onTap: onTap,
            child: Text(
              pitch.info,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
          );
  }
}
