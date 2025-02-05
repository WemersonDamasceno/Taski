import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/create_task/domain/usecase/create_task_usecase.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_bloc.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_event.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_state.dart';

class MockCreateTaskUsecase extends Mock implements CreateTaskUsecase {}

void main() {
  late CreateTaskBloc bloc;
  late MockCreateTaskUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockCreateTaskUsecase();
    bloc = CreateTaskBloc(createTaskUsecase: mockUsecase);
  });

  group('CreateTaskBloc', () {
    blocTest<CreateTaskBloc, CreateTaskState>(
      'emits [loading, success] when CreateTask is added and usecase succeeds',
      build: () {
        when(() => mockUsecase()).thenAnswer((_) async => (true, null));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateTask(task: 'New Task', note: 'Task Note')),
      expect: () => [
        const CreateTaskState(stateEnum: StateEnum.loading),
        const CreateTaskState(stateEnum: StateEnum.success),
      ],
    );

    blocTest<CreateTaskBloc, CreateTaskState>(
      'emits [loading, error] when CreateTask is added and usecase fails',
      build: () {
        when(() => mockUsecase()).thenAnswer(
            (_) async => (false, const GenericsFailure(message: 'Error')));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateTask(task: 'New Task', note: 'Task Note')),
      expect: () => [
        const CreateTaskState(stateEnum: StateEnum.loading),
        const CreateTaskState(stateEnum: StateEnum.error),
      ],
    );

    blocTest<CreateTaskBloc, CreateTaskState>(
      'emits [loading, error] when CreateTask is added and an exception is thrown',
      build: () {
        when(() => mockUsecase()).thenThrow(Exception('Unexpected error'));
        return bloc;
      },
      act: (bloc) => bloc.add(CreateTask(task: 'New Task', note: 'Task Note')),
      expect: () => [
        const CreateTaskState(stateEnum: StateEnum.loading),
        const CreateTaskState(stateEnum: StateEnum.error),
      ],
    );
  });
}
