import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';

class UpdateTaskState extends Equatable {
  final TaskModel? task;
  final StateEnum stateEnum;

  const UpdateTaskState({
    this.task,
    this.stateEnum = StateEnum.initial,
  });

  UpdateTaskState copyWith({
    TaskModel? task,
    StateEnum? stateEnum,
  }) {
    return UpdateTaskState(
      task: task ?? this.task,
      stateEnum: stateEnum ?? this.stateEnum,
    );
  }

  @override
  List<Object?> get props => [task, stateEnum];
}
