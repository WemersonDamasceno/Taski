import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/features/search_task/bloc/search_task_state.dart';

void main() {
  group('SearchTasksState Tests', () {
    test('States with the same properties should be equal', () {
      expect(
        const SearchTasksState(tasks: [], stateEnum: StateEnum.initial),
        const SearchTasksState(tasks: [], stateEnum: StateEnum.initial),
      );
    });

    test('copyWith should update state correctly', () {
      const state = SearchTasksState();
      final newState = state.copyWith(stateEnum: StateEnum.loading);
      expect(newState.stateEnum, StateEnum.loading);
    });
  });
}
