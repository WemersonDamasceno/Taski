import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_state.dart';

void main() {
  group('StateListTask', () {
    test('StateListTask should be equal when properties are the same', () {
      final state1 = StateListTask(
        tasks: [TaskModel(id: 1, title: 'Task 1', description: 'Description')],
        stateEnum: StateEnum.success,
      );
      final state2 = StateListTask(
        tasks: [TaskModel(id: 1, title: 'Task 1', description: 'Description')],
        stateEnum: StateEnum.success,
      );

      expect(state1, state2);
    });

    test('StateListTask should not be equal when properties are different', () {
      final state1 = StateListTask(
        tasks: [TaskModel(id: 1, title: 'Task 1', description: 'Description')],
        stateEnum: StateEnum.success,
      );
      final state2 = StateListTask(
        tasks: [TaskModel(id: 2, title: 'Task 2', description: 'Description')],
        stateEnum: StateEnum.error,
      );

      expect(state1, isNot(equals(state2)));
    });

    test('copyWith should return a new instance with updated properties', () {
      final state = StateListTask(
        tasks: [TaskModel(id: 1, title: 'Task 1', description: 'Description')],
        stateEnum: StateEnum.success,
      );

      final updatedState = state.copyWith(
        tasks: [
          TaskModel(id: 2, title: 'Task 2', description: 'Description 2'),
        ],
        stateEnum: StateEnum.loading,
      );

      expect(updatedState.tasks,
          [TaskModel(id: 2, title: 'Task 2', description: 'Description 2')],);
      expect(updatedState.stateEnum, StateEnum.loading);
    });
  });
}
