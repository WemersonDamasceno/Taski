import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_event.dart';

void main() {
  group('ListDoneTaskEvent', () {
    test('GetCompletedTasksEvent has no properties', () {
      final event = GetCompletedTasksEvent();

      expect(event.props, []);
    });

    test('DeleteAllTasksDone has no properties', () {
      final event = DeleteAllTasksDone();

      expect(event.props, []);
    });

    test('DeleteTasksById has the correct id in props', () {
      final event = DeleteTasksById(id: 123);

      expect(event.props, [123]);
    });

    test('DeleteTasksById equality check', () {
      final event1 = DeleteTasksById(id: 123);
      final event2 = DeleteTasksById(id: 123);
      final event3 = DeleteTasksById(id: 456);

      expect(event1, event2);
      expect(event1, isNot(event3));
    });
  });
}
