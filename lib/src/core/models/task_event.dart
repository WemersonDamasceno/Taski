import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:taski/src/core/models/task_model.dart';

class TaskEventBus {
  static final TaskEventBus _instance = TaskEventBus._internal();

  factory TaskEventBus() => _instance;

  TaskEventBus._internal();

  final _controller = StreamController<TaskEvent>.broadcast();

  Stream<TaskEvent> get stream => _controller.stream;

  void emit(TaskEvent event) {
    _controller.sink.add(event);
  }

  void dispose() {
    _controller.close();
  }
}

class TaskEvent extends Equatable {
  final TaskModel? task;
  final TaskOperation operation;

  const TaskEvent(this.task, this.operation);

  @override
  List<Object?> get props => [task, operation];
}

enum TaskOperation {
  delete,
  createOrUpdate,
}
