import 'dart:async';

import 'package:threadfon/src/features/02_selection_diameter/model/diameter_model.dart';

abstract class IDiameterRepository {
  Future<List<DiameterModel>> fetchDiameters();
}
