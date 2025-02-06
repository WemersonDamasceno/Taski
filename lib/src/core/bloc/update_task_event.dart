import 'package:equatable/equatable.dart';
import 'package:taski/src/core/models/task_model.dart';

abstract class UpdateTaskEvent extends Equatable {}

class UpdateTask extends UpdateTaskEvent {
  final TaskModel taskModel;

  UpdateTask({required this.taskModel});

  @override
  List<Object?> get props => [taskModel];
}
