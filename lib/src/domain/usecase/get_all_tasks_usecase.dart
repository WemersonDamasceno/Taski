import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class GetAllTasksUsecase implements Usecase<List<TaskModel>, NoParams> {
  final TaskRepository _repository;

  GetAllTasksUsecase({required TaskRepository repository})
      : _repository = repository;

  @override
  Future<(List<TaskModel>?, Failure?)> call(NoParams params) async {
    try {
      final tasks = await _repository.getUncompletedTasks();
      return (tasks, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}
