import 'package:taski/src/core/models/task_model.dart';

abstract class TaskRepository {
  Future<List<TaskModel>> getUncompletedTasks();
  Future<List<TaskModel>> getDoneTasks();

  Future<int> insertTask(TaskModel task);
  Future<int> updateTask(TaskModel task);
  Future<int> deleteTask(int id);
  Future<int> deleteUncompletedTasks();
  Future<List<TaskModel>> getTasksByTitle(String title);
}
