import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class GetQuantityUncompltedTaskUsecase implements Usecase<int, NoParams> {
  GetQuantityUncompltedTaskUsecase({
    required TaskRepository repository,
  }) : _repository = repository;
  final TaskRepository _repository;

  @override
  Future<(int?, Failure?)> call(NoParams params) async {
    try {
      final quantity = await _repository.getQuantityOfUncompletedTasks();
      return (quantity, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}
