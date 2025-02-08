import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/models/task_model.dart';

void main() {
  group('TaskModel tests', () {
    final taskData = {
      'id': 1,
      'title': 'Test Task',
      'description': 'Test Description',
      'isCompleted': 1,
    };
    final task = TaskModel(
      id: 1,
      title: 'Test Task',
      description: 'Test Description',
      isCompleted: true,
    );

    test('TaskModel should correctly map to a map and back', () {
      final taskFromMap = TaskModel.fromMap(taskData);
      final taskToMap = task.toMap();

      expect(taskFromMap, equals(task));
      expect(taskToMap, equals(taskData));
    });

    test('TaskModel copyWith should create a new instance with updated values',
        () {
      final updatedTask = task.copyWith(title: 'Updated Task');

      expect(updatedTask.title, 'Updated Task');
      expect(updatedTask.description, 'Test Description');
      expect(updatedTask.isCompleted, true);
      expect(updatedTask.id, 1);
    });

    test('TaskModel copyWith should keep unchanged values when not provided',
        () {
      final updatedTask = task.copyWith();

      expect(updatedTask.title, 'Test Task');
      expect(updatedTask.description, 'Test Description');
      expect(updatedTask.isCompleted, true);
      expect(updatedTask.id, 1);
    });

    test('TaskModel equality should compare correctly', () {
      final task2 = TaskModel(
        id: 1,
        title: 'Test Task',
        description: 'Test Description',
        isCompleted: true,
      );
      final task3 = TaskModel(
        id: 2,
        title: 'Another Task',
        description: 'Test Description',
        isCompleted: false,
      );

      expect(task, equals(task2));
      expect(task, isNot(equals(task3)));
    });
  });
}
