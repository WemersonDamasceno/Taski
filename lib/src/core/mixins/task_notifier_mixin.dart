import 'package:flutter/material.dart';
import 'package:taski/src/core/models/task_event.dart';
import 'package:taski/src/core/models/task_model.dart';

abstract class TaskNotifierContract {
  void notifyTaskModification(TaskModel? task, TaskOperation operation);
}

mixin TaskNotifierMixin<T extends StatefulWidget> on State<T>
    implements TaskNotifierContract {
  @override
  void notifyTaskModification(TaskModel? task, TaskOperation operation) {
    if (!mounted) return;
    TaskEventBus().emit(TaskEvent(task, operation));
  }
}
