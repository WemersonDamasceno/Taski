import 'package:equatable/equatable.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class CreateTaskUsecase implements Usecase<TaskModel, CreateTaskParams> {
  final TaskRepository _repository;

  CreateTaskUsecase({required TaskRepository repository})
      : _repository = repository;

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
  final String task;
  final String note;

  const CreateTaskParams({
    required this.task,
    required this.note,
  });

  @override
  List<Object?> get props => [task, note];
}
