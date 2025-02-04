import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/list_task/data/mocks/tasks_mocks.dart';
import 'package:taski/src/list_task/presentation/models/task_model.dart';

class FetchTasksUseCase implements Usecase<List<TaskModel>, NoParams> {
  @override
  Future<(List<TaskModel>?, Failure?)> call() async {
    await Future.delayed(const Duration(seconds: 1));
    return (mockListTasks, null);
  }
}
