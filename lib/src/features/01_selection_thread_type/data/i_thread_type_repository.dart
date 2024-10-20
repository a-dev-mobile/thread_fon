import 'package:threadfon/src/features/01_selection_thread_type/model/thread_type_model.dart';

abstract class IThreadTypeRepository {
  Future<List<ThreadTypeModel>> fetchThreadTypes();
}
