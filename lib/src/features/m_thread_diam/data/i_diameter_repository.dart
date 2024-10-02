import 'dart:async';

import 'package:threadfon/src/features/m_thread_diam/model/diameter_model.dart';




abstract class IDiameterRepository {
  Future<List<DiameterModel>> fetchDiameters();
}
