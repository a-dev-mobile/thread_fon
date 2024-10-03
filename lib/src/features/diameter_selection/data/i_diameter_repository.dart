import 'dart:async';

import 'package:threadfon/src/features/diameter_selection/model/diameter_model.dart';




abstract class IDiameterRepository {
  Future<List<DiameterModel>> fetchDiameters();
}
