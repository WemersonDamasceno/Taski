import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_event.dart';

void main() {
  group('ListTaskEvent', () {
    test('GetUncompletedTasksEvent props should be empty list', () {
      final event = GetUncompletedTasksEvent();
      expect(event.props, []);
    });
  });
}
