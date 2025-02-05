import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/features/create_task/bloc/create_task_event.dart';

void main() {
  late CreateTask event;

  setUp(() {
    event = CreateTask(task: 'Test Task', note: 'Test Note');
  });

  group('CreateTaskEvent', () {
    test('events: should support value comparisons', () {
      expect(CreateTask(task: 'Test Task', note: 'Test Note'),
          CreateTask(task: 'Test Task', note: 'Test Note'));
    });

    test('should have correct props', () {
      expect(event.props, ['Test Task', 'Test Note']);
    });
  });
}
