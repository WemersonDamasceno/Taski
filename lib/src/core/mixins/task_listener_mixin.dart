import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taski/src/core/models/task_event.dart';

abstract class TaskListenerContract {
  void onTaskModified(TaskEvent event);
}

mixin TaskListenerMixin<T extends StatefulWidget> on State<T>
    implements TaskListenerContract {
  StreamSubscription<TaskEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = TaskEventBus().stream.listen(_handleTaskEvent);
  }

  void _handleTaskEvent(TaskEvent event) {
    onTaskModified(event);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
