import 'package:threadfon/core/constant/enums_thread_type.dart';
import 'package:threadfon/features/01_thread_type_selection/data/i_thread_type_repository.dart';
import 'package:threadfon/features/01_thread_type_selection/model/thread_type_model.dart';

class ThreadTypeRepositoryImpl implements IThreadTypeRepository {
  // Placeholder for any dependencies, such as a ApiService

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
