import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class GetUncompletedTasksUsecase implements Usecase<List<TaskModel>, NoParams> {
  final TaskRepository repository;

  GetUncompletedTasksUsecase({required this.repository});

  @override
  Future<(List<TaskModel>?, Failure?)> call(NoParams params) async {
    try {
      final tasksUncompleted = await repository.getUncompletedTasks();

      return (tasksUncompleted, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}
