import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/data/services/local_datastorage.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class ListTaskRepositoryImpl implements ListTaskRepository {
  final DatabaseService databaseService;

  ListTaskRepositoryImpl({required this.databaseService});

  @override
  Future<List<TaskModel>> getUncompletedTasks() async {
    return await databaseService.getUncompletedTasks();
  }
}
