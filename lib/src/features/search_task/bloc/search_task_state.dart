import 'package:equatable/equatable.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';

class SearchTasksState extends Equatable {

  const SearchTasksState({
    this.tasks = const [],
    this.stateEnum = StateEnum.initial,
  });
  final List<TaskModel> tasks;
  final StateEnum stateEnum;

  SearchTasksState copyWith({
    List<TaskModel>? tasks,
    StateEnum? stateEnum,
  }) {
    return SearchTasksState(
      tasks: tasks ?? List.from(this.tasks),
      stateEnum: stateEnum ?? this.stateEnum,
    );
  }

  @override
  List<Object?> get props => [tasks, stateEnum];
}
