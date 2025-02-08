import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/bloc/update_task_state.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';

void main() {
  final task = TaskModel(id: 1, title: 'Task Test', description: 'Description');

  test('UpdateTaskState should have the correct initial values', () {
    const state = UpdateTaskState();
    expect(state.task, isNull);
    expect(state.stateEnum, StateEnum.initial);
  });

  test('UpdateTaskState should be equal when all fields are the same', () {
    final state1 = UpdateTaskState(task: task, stateEnum: StateEnum.success);
    final state2 = state1.copyWith(task: task, stateEnum: StateEnum.success);

    expect(state1, equals(state2));
  });

  test('UpdateTaskState should not be equal when fields are different', () {
    final state1 = UpdateTaskState(task: task, stateEnum: StateEnum.success);
    final state2 = UpdateTaskState(task: task, stateEnum: StateEnum.error);

    expect(state1, isNot(equals(state2)));
  });
}
