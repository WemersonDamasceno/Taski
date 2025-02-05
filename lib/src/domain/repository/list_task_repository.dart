import 'package:taski/src/core/models/task_model.dart';

abstract class ListTaskRepository {
  Future<List<TaskModel>> getUncompletedTasks();
}
