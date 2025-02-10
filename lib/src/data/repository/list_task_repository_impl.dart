import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/data/services/local_datastorage.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  TaskRepositoryImpl({required this.databaseService});
  final LocalDatabaseService databaseService;

  @override
  Future<List<TaskModel>> getUncompletedTasks() async {
    return await databaseService.getUncompletedTasks();
  }

  @override
  Future<int> getQuantityOfUncompletedTasks() async {
    return await databaseService.quantityOfUncompletedTasks();
  }

  @override
  Future<List<TaskModel>> getDoneTasks() async {
    return await databaseService.getCompletedTasks();
  }

  @override
  Future<int> insertTask(TaskModel task) async {
    return await databaseService.insertTask(task);
  }

  @override
  Future<int> deleteTask(int id) async {
    return await databaseService.deleteTask(id);
  }

  @override
  Future<int> deleteAllDoneTasks() async {
    return await databaseService.deleteAllDoneTasks();
  }

  @override
  Future<List<TaskModel>> getTasksByTitle(String title) async {
    return await databaseService.getTasksByTitle(title);
  }

  @override
  Future<int> updateTask(TaskModel task) async {
    return await databaseService.updateTask(task);
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    return await databaseService.getAllTasks();
  }
}
