import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_state.dart';

void main() {
  group('GetQuantityTasksState', () {
    test('supports value comparison', () {
      expect(
        const GetQuantityTasksState(
            quantityOfTasks: 5, stateEnum: StateEnum.success),
        equals(const GetQuantityTasksState(
            quantityOfTasks: 5, stateEnum: StateEnum.success)),
      );
    });

    test('copyWith updates state correctly', () {
      const state = GetQuantityTasksState(
          quantityOfTasks: 5, stateEnum: StateEnum.initial);

      final updatedState =
          state.copyWith(quantityOfTasks: 10, stateEnum: StateEnum.success);

      expect(updatedState.quantityOfTasks, 10);
      expect(updatedState.stateEnum, StateEnum.success);
    });

    test('props contains correct values', () {
      const state = GetQuantityTasksState(
          quantityOfTasks: 5, stateEnum: StateEnum.success);

      expect(state.props, [5, StateEnum.success]);
    });
  });
}
