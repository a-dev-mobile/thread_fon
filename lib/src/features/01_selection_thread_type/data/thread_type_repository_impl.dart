import 'package:threadfon/src/common/constant/enums_thread_type.dart';
import 'package:threadfon/src/features/01_selection_thread_type/data/i_thread_type_repository.dart';
import 'package:threadfon/src/features/01_selection_thread_type/model/thread_type_model.dart';

class ThreadTypeRepositoryImpl implements IThreadTypeRepository {
  // Placeholder for any dependencies, such as a DatabaseService

  @override
  Future<List<ThreadTypeModel>> fetchThreadTypes() async {
    // Since we don't have database queries now, we'll return hardcoded data.
    // This can be replaced with actual database queries in the future.

    return [
      const ThreadTypeModel(
        enumThreadType: EnumThreadType.f,
        svgAssetPath: 'assets/svg/gaika.svg',
      ),
      const ThreadTypeModel(
        enumThreadType: EnumThreadType.m,
        svgAssetPath: 'assets/svg/bolt.svg',
      ),
    ];
  }
}
