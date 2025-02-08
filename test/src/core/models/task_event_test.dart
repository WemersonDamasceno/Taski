import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/models/task_event.dart';
import 'package:taski/src/core/models/task_model.dart';

void main() {
  late TaskEventBus taskEventBus;
  late TaskModel taskModel =
      TaskModel(id: 1, title: 'Task Test', description: 'Description');
  late TaskEvent taskEvent;

  setUp(() {
    taskEventBus = TaskEventBus();
    taskEvent = TaskEvent(taskModel, TaskOperation.createOrUpdate);
  });

  tearDown(() {
    taskEventBus.dispose();
  });

  group('TaskEventBus tests', () {
    test('Should emit a TaskEvent when emit is called', () async {
      final completer = Completer<void>();

      taskEventBus.stream.listen(
        expectAsync1((event) {
          expect(event, taskEvent);
          completer.complete();
        }),
      );

      taskEventBus.emit(taskEvent);

      await completer.future;
    });
  });

  group('TaskEvent tests', () {
    test('TaskEvent equality should work correctly', () {
      final task =
          TaskModel(id: 1, title: 'Test', description: 'Test Description');
      final event1 = TaskEvent(task, TaskOperation.createOrUpdate);
      final event2 = TaskEvent(task, TaskOperation.createOrUpdate);
      final event3 = TaskEvent(task, TaskOperation.delete);

      expect(event1, equals(event2));
      expect(event1, isNot(equals(event3)));
    });

    test('TaskEvent props should include task and operation', () {
      final task =
          TaskModel(id: 1, title: 'Test', description: 'Test Description');
      final taskEvent = TaskEvent(task, TaskOperation.createOrUpdate);

      expect(taskEvent.props, [task, TaskOperation.createOrUpdate]);
    });
  });
}
