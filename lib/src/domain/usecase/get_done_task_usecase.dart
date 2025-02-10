import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class GetDoneTaskUsecase implements Usecase<List<TaskModel>, NoParams> {
  GetDoneTaskUsecase({
    required TaskRepository repository,
  }) : _repository = repository;
  final TaskRepository _repository;

  @override
  Future<(List<TaskModel>?, Failure?)> call(NoParams params) async {
    try {
      final tasksDone = await _repository.getDoneTasks();

      return (tasksDone, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}
