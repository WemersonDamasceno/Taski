import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/bloc/update_task_event.dart';
import 'package:taski/src/core/models/task_model.dart';

void main() {
  final task = TaskModel(id: 1, title: 'Task Test', description: 'Description');

  test('UpdateTask props should contain taskModel', () {
    final event = UpdateTask(taskModel: task);
    expect(event.props, [task]);
  });

  test('Two UpdateTask objects with the same values should be equal', () {
    final event1 = UpdateTask(taskModel: task);
    final event2 = UpdateTask(taskModel: task);

    expect(event1, equals(event2));
  });
}
