import 'package:threadfon/core/constant/assets.gen.dart';
import 'package:threadfon/core/constant/enum_thread_male_female.dart';
import 'package:threadfon/core/services/logging/logger.dart';
import 'package:threadfon/features/02_thread_type_selection/models/thread_type_model.dart';

final LogService _logger = LogService('thread_type_repository');

class ThreadTypeRepository {
  Future<List<ThreadTypeModel>> fetchThreadTypes() async {
    try {
      // В будущем можно добавить API вызовы или локальное хранилище
      return <ThreadTypeModel>[
        ThreadTypeModel(
          enumThreadType: EnumThreadMaleFemale.female,
          svgAssetPath: Assets.svg.gaika,
        ),
        ThreadTypeModel(
          enumThreadType: EnumThreadMaleFemale.male,
          svgAssetPath: Assets.svg.bolt,
        ),
      ];
    } catch (e, s) {
      _logger.e('Error fetching thread types', error: e, stackTrace: s);
      Error.throwWithStackTrace(e, s);
    }
  }
}
