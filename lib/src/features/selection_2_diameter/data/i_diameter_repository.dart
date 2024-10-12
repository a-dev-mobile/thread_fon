import 'dart:async';

import 'package:threadfon/src/features/selection_2_diameter/model/diameter_model.dart';

abstract class IDiameterRepository {
  Future<List<DiameterModel>> fetchDiameters();
}
