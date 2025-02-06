import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class DeleteAllTasksDoneUsecase implements Usecase<bool, NoParams> {
  final TaskRepository _repository;

  DeleteAllTasksDoneUsecase({required TaskRepository repository})
      : _repository = repository;

  @override
  Future<(bool?, Failure?)> call(NoParams params) async {
    try {
      final result = await _repository.deleteAllDoneTasks();
      return (result > 0, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}
