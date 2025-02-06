import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';

class CreateTaskState extends Equatable {
  final StateEnum stateEnum;
  final TaskModel? taskCreated;

  const CreateTaskState({
    this.taskCreated,
    this.stateEnum = StateEnum.initial,
  });

  @override
  List<Object> get props => [stateEnum];

  CreateTaskState copyWith({
    TaskModel? taskCreated,
    StateEnum? stateEnum,
  }) {
    return CreateTaskState(
      taskCreated: taskCreated ?? this.taskCreated,
      stateEnum: stateEnum ?? this.stateEnum,
    );
  }
}
