import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_event.dart';

void main() {
  group('GetQuantityTasksEvent', () {
    test('GetQuantityUncompletedTasks props are empty list', () {
      final event = GetQuantityUncompletedTasks();
      expect(event.props, isEmpty);
    });
  });
}
