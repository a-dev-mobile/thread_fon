import 'package:threadfon/core/constant/assets.gen.dart';
import 'package:threadfon/core/constant/enum_thread_type.dart';

import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

class ThreadTypeRepository {
  // Placeholder for any dependencies, such as a ApiService

  Future<List<ThreadTypeModel>> fetchThreadTypes() async {
    // Since we don't have database queries now, we'll return hardcoded data.
    // This can be replaced with actual database queries in the future.

    return [
      ThreadTypeModel(
        enumThreadType: EnumThreadType.f,
        svgAssetPath: Assets.svg.gaika,
      ),
      ThreadTypeModel(
        enumThreadType: EnumThreadType.m,
        svgAssetPath: Assets.svg.bolt,
      ),
    ];
  }
}
