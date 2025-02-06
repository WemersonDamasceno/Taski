import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class DeleteTasksByIdUsecase implements Usecase<bool, int> {
  final TaskRepository _repository;

  DeleteTasksByIdUsecase({required TaskRepository repository})
      : _repository = repository;
  @override
  Future<(bool?, Failure?)> call(int idTask) async {
    try {
      final result = await _repository.deleteTask(idTask);
      return (result > 0, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}
