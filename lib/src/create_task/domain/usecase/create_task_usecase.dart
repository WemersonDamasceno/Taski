import 'package:equatable/equatable.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';

class CreateTaskUsecase implements Usecase<bool, CreateTaskParams> {
  @override
  Future<(bool?, Failure?)> call() async {
    await Future.delayed(const Duration(seconds: 1));
    return (true, null);
  }
}

class CreateTaskParams extends Equatable {
  final String task;
  final String note;

  const CreateTaskParams({
    required this.task,
    required this.note,
  });

  @override
  List<Object?> get props => [task, note];
}
