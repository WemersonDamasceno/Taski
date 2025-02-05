import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_state.dart';

void main() {
  late CreateTaskState initialState;

  setUp(() {
    initialState = const CreateTaskState();
  });

  group('CreateTaskState', () {
    test('should have correct initial state', () {
      expect(initialState.props, [StateEnum.initial]);
    });

    test('should allow copying with new stateEnum', () {
      final newState = initialState.copyWith(stateEnum: StateEnum.loading);
      expect(newState.stateEnum, StateEnum.loading);
    });
  });
}
