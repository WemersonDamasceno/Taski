import 'package:equatable/equatable.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class SearchTasksByTitleUseCase
    implements Usecase<List<TaskModel>, SearchTaskParams> {
  final TaskRepository _repository;

  SearchTasksByTitleUseCase({required TaskRepository repository})
      : _repository = repository;

  @override
  Future<(List<TaskModel>?, Failure?)> call(SearchTaskParams params) async {
    try {
      final tasks = await _repository.getTasksByTitle(params.title);
      return (tasks, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}

class SearchTaskParams extends Equatable {
  final String title;
  const SearchTaskParams({required this.title});
  @override
  List<Object?> get props => [title];
}
