import 'package:equatable/equatable.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class CreateTaskUsecase implements Usecase<TaskModel, CreateTaskParams> {
  CreateTaskUsecase({required TaskRepository repository})
      : _repository = repository;
  final TaskRepository _repository;

  @override
  Future<(TaskModel?, Failure?)> call(CreateTaskParams params) async {
    try {
      final taskModel = TaskModel(title: params.task, description: params.note);
      await _repository.insertTask(taskModel);
      return (taskModel, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}

class CreateTaskParams extends Equatable {
  const CreateTaskParams({
    required this.task,
    required this.note,
  });
  final String task;
  final String note;

  @override
  List<Object?> get props => [task, note];
}
