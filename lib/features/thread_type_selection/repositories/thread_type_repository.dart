import 'package:threadfon/core/constant/assets.gen.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/thread_type_selection/models/thread_type_model.dart';

final _logger = LogService('thread_type_repository');

class ThreadTypeRepository {
  Future<List<ThreadTypeModel>> fetchThreadTypes() async {
    try {
      // В будущем можно добавить API вызовы или локальное хранилище
      return [
        ThreadTypeModel(
          enumThreadType: EnumThreadMaleFemale.female,
          svgAssetPath: Assets.svg.gaika,
        ),
        ThreadTypeModel(
          enumThreadType: EnumThreadMaleFemale.male,
          svgAssetPath: Assets.svg.bolt,
        ),
      ];
    } catch (error, stackTrace) {
      _logger.e('Error fetching thread types', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}
