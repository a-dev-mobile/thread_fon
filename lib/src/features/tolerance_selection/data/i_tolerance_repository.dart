import 'dart:async';


import 'package:threadfon/src/features/tolerance_selection/model/tolerance_model.dart';

abstract class IToleranceRepository {
  Future<List<ToleranceModel>> fetchTolerances(double diameter);
}
