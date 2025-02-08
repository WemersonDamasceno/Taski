import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/bloc/update_task_bloc.dart';
import 'package:taski/src/core/bloc/update_task_event.dart';
import 'package:taski/src/core/bloc/update_task_state.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/domain/usecase/update_task_usecase.dart';

class MockUpdateTaskUsecase extends Mock implements UpdateTaskUsecase {}

void main() {
  late UpdateTaskBloc updateTaskBloc;
  late MockUpdateTaskUsecase mockUpdateTaskUsecase;
  final task = TaskModel(
    id: 1,
    title: 'Task Test',
    description: 'Description',
  );

  setUp(() {
    mockUpdateTaskUsecase = MockUpdateTaskUsecase();
    updateTaskBloc = UpdateTaskBloc(updateTaskUsecase: mockUpdateTaskUsecase);
  });

  tearDown(() {
    updateTaskBloc.close();
  });

  test('Initial state should be UpdateTaskState() with StateEnum.initial', () {
    expect(updateTaskBloc.state, const UpdateTaskState());
  });

  blocTest<UpdateTaskBloc, UpdateTaskState>(
    'Should emit [loading, success] when the update is successful',
    build: () {
      when(() => mockUpdateTaskUsecase.call(task))
          .thenAnswer((_) async => (task, null));
      return updateTaskBloc;
    },
    act: (bloc) => bloc.add(UpdateTask(taskModel: task)),
    expect: () => [
      const UpdateTaskState(stateEnum: StateEnum.loading),
      UpdateTaskState(task: task, stateEnum: StateEnum.success),
    ],
  );

  blocTest<UpdateTaskBloc, UpdateTaskState>(
    'Should emit [loading, error] when the update fails',
    build: () {
      when(() => mockUpdateTaskUsecase.call(task))
          .thenAnswer((_) async => (null, GenericsFailure()));
      return updateTaskBloc;
    },
    act: (bloc) => bloc.add(UpdateTask(taskModel: task)),
    expect: () => [
      const UpdateTaskState(stateEnum: StateEnum.loading),
      const UpdateTaskState(stateEnum: StateEnum.error),
    ],
  );

  blocTest<UpdateTaskBloc, UpdateTaskState>(
    'Should emit [loading, error] when an exception occurs',
    build: () {
      when(() => mockUpdateTaskUsecase.call(task))
          .thenThrow(Exception('Unexpected error'));
      return updateTaskBloc;
    },
    act: (bloc) => bloc.add(UpdateTask(taskModel: task)),
    expect: () => [
      const UpdateTaskState(stateEnum: StateEnum.loading),
      const UpdateTaskState(stateEnum: StateEnum.error),
    ],
  );
}
