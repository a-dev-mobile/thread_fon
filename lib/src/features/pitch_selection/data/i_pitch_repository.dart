import 'dart:async';

import 'package:threadfon/src/features/pitch_selection/model/pitch_model.dart';

abstract class IPitchRepository {
  Future<List<PitchModel>> fetchPitchs(double diameter);
}
