import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';

class DeleteTasksByIdUsecase implements Usecase<bool, int> {
  @override
  Future<(bool?, Failure?)> call(int idTask) async {
    await Future.delayed(const Duration(seconds: 1));
    return (true, null);
  }
}
