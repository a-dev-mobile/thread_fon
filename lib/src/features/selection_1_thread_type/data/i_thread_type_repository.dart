import 'package:threadfon/src/features/selection_1_thread_type/model/thread_type_model.dart';

abstract class IThreadTypeRepository {
  Future<List<ThreadTypeModel>> fetchThreadTypes();
}
