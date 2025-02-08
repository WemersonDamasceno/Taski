import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_state.dart';

void main() {
  group('ListDoneTaskState', () {
    test('initial state is correct', () {
      const state = ListDoneTaskState();
      expect(state.tasks, isNull);
      expect(state.stateEnum, StateEnum.initial);
    });

    test('copyWith works correctly', () {
      final state = ListDoneTaskState(
        tasks: [TaskModel(id: 1, title: 'Test', description: 'Description')],
        stateEnum: StateEnum.success,
      );

      final newState = state.copyWith(
        tasks: [
          TaskModel(id: 2, title: 'New Task', description: 'Description')
        ],
        stateEnum: StateEnum.loading,
      );

      expect(newState.tasks?.length, 1);
      expect(newState.tasks?.first.id, 2);
      expect(newState.stateEnum, StateEnum.loading);
    });

    test('copyWith preserves unmodified properties', () {
      final state = ListDoneTaskState(
        tasks: [TaskModel(id: 1, title: 'Test', description: 'Description')],
        stateEnum: StateEnum.success,
      );

      final newState = state.copyWith();

      expect(newState.tasks, state.tasks);
      expect(newState.stateEnum, state.stateEnum);
    });

    test('ListDoneTaskState equality check', () {
      final state1 = ListDoneTaskState(
        tasks: [TaskModel(id: 1, title: 'Test', description: 'Description')],
        stateEnum: StateEnum.success,
      );
      final state2 = ListDoneTaskState(
        tasks: [TaskModel(id: 1, title: 'Test', description: 'Description')],
        stateEnum: StateEnum.success,
      );
      final state3 = ListDoneTaskState(
        tasks: [
          TaskModel(id: 2, title: 'Different Task', description: 'Description')
        ],
        stateEnum: StateEnum.loading,
      );

      expect(state1, state2);
      expect(state1, isNot(state3));
    });
  });
}
