import 'package:threadfon/features/01_thread_type_selection/model/thread_type_model.dart';

abstract class IThreadTypeRepository {
  Future<List<ThreadTypeModel>> fetchThreadTypes();
}
