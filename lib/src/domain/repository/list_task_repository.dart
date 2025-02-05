import 'package:taski/src/core/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getUncompletedTasks();
}
