import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';

abstract class ListTaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StateListTask extends ListTaskState {
  final List<TaskModel>? tasks;
  final StateEnum stateEnum;

  StateListTask({
    this.tasks,
    this.stateEnum = StateEnum.initial,
  });

  StateListTask copyWith({
    List<TaskModel>? tasks,
    StateEnum? stateEnum,
  }) {
    return StateListTask(
      tasks: tasks ?? this.tasks,
      stateEnum: stateEnum ?? this.stateEnum,
    );
  }

  @override
  List<Object?> get props => [tasks, stateEnum];
}
