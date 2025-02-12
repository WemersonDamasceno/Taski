import 'package:equatable/equatable.dart';
import 'package:taski/src/core/models/task_model.dart';

abstract class UpdateTaskEvent extends Equatable {}

class UpdateTask extends UpdateTaskEvent {
  UpdateTask({required this.taskModel});
  final TaskModel taskModel;

  @override
  List<Object?> get props => [taskModel];
}
