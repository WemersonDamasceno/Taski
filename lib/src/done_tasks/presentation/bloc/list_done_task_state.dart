import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';

class ListDoneTaskState extends Equatable {
  final List<TaskModel>? tasks;
  final StateEnum stateEnum;

  const ListDoneTaskState({
    this.tasks,
    this.stateEnum = StateEnum.initial,
  });

  ListDoneTaskState copyWith({
    List<TaskModel>? tasks,
    StateEnum? stateEnum,
  }) {
    return ListDoneTaskState(
      tasks: tasks ?? this.tasks,
      stateEnum: stateEnum ?? this.stateEnum,
    );
  }

  @override
  List<Object?> get props => [tasks, stateEnum];
}
