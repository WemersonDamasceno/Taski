import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class UpdateTaskUsecase implements Usecase<TaskModel, TaskModel> {
  UpdateTaskUsecase({required TaskRepository repository})
      : _repository = repository;
  final TaskRepository _repository;

  @override
  Future<(TaskModel?, Failure?)> call(TaskModel task) async {
    try {
      await _repository.updateTask(task);
      return (task, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}
