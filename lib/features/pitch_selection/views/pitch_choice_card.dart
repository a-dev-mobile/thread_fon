import 'package:flutter/material.dart';
import 'package:threadfon/core/widgets/choice_card.dart';
import 'package:threadfon/features/pitch_selection/models/pitch_model.dart';

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
    return ChoiceCard(
      isHeader: pitch.enumPitchDataType == EnumPitchDataType.header,
      onTap: pitch.enumPitchDataType == EnumPitchDataType.value ? onTap : null,
      child: pitch.enumPitchDataType == EnumPitchDataType.header
          ? Text(
              pitch.info,
              textAlign: TextAlign.center,
            )
          : Text(
              pitch.info,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
              textAlign: TextAlign.center,
            ),
    );
  }
}
