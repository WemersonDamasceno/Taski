import 'package:equatable/equatable.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/data/mocks/tasks_mocks.dart';

class SearchTasksByTitleUseCase
    implements Usecase<List<TaskModel>, SearchTaskParams> {
  @override
  Future<(List<TaskModel>?, Failure?)> call(SearchTaskParams params) async {
    // TODO: Simulando a busca de tarefas pelo título
    final filteredTasks = mockListTasks
        .where(
          (task) =>
              task.title.toLowerCase().contains(params.title.toLowerCase()),
        )
        .toList();
    return (filteredTasks, null);
  }
}

class SearchTaskParams extends Equatable {
  final String title;
  const SearchTaskParams({required this.title});
  @override
  List<Object?> get props => [title];
}
