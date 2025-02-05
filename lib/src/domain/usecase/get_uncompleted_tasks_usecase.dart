import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class FetchTasksUseCase implements Usecase<List<TaskModel>, NoParams> {
  final TaskRepository repository;

  FetchTasksUseCase({required this.repository});

  @override
  Future<(List<TaskModel>?, Failure?)> call(NoParams params) async {
    try {
      final tasksUncompleted = await repository.getUncompletedTasks();

      return (tasksUncompleted, null);
    } catch (e) {
      return (null, LocalStorageFailure());
    }
  }
}
