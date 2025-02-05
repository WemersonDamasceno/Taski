import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';

class DeleteAllTasksDoneUsecase implements Usecase<List<TaskModel>, NoParams> {
  @override
  Future<(List<TaskModel>?, Failure?)> call(NoParams params) async {
    await Future.delayed(const Duration(seconds: 1));
    // TODO: Simulando o retorno das tasks
    return (<TaskModel>[], null);
  }
}
