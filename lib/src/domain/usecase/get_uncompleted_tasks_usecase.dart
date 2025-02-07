import 'package:equatable/equatable.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';

class GetUncompletedTasksUsecase
    implements Usecase<List<TaskModel>, GetTasksPaginationParams> {
  final TaskRepository repository;

  GetUncompletedTasksUsecase({required this.repository});

  @override
  Future<(List<TaskModel>?, Failure?)> call(
      GetTasksPaginationParams params) async {
    try {
      final tasksUncompleted = await repository.getUncompletedTasks(
        limit: params.limit,
        offset: params.offset,
      );

      return (tasksUncompleted, null);
    } on LocalStorageException {
      return (null, LocalStorageFailure());
    } catch (e) {
      return (null, GenericsFailure());
    }
  }
}

class GetTasksPaginationParams extends Equatable {
  final int limit;
  final int offset;

  const GetTasksPaginationParams({
    required this.limit,
    required this.offset,
  });

  @override
  List<Object?> get props => [limit, offset];
}
