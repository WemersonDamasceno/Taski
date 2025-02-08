import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/usecase/delete_all_tasks_done_usecase.dart';
import 'package:taski/src/domain/usecase/delete_task_by_id_usecase.dart';
import 'package:taski/src/domain/usecase/get_done_task_usecase.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_bloc.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_event.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_state.dart';

class MockGetDoneTaskUsecase extends Mock implements GetDoneTaskUsecase {}

class MockDeleteAllTasksDoneUsecase extends Mock
    implements DeleteAllTasksDoneUsecase {}

class MockDeleteTasksByIdUsecase extends Mock
    implements DeleteTasksByIdUsecase {}

void main() {
  late ListDoneTaskBloc bloc;
  late MockGetDoneTaskUsecase mockGetDoneTaskUsecase;
  late MockDeleteAllTasksDoneUsecase mockDeleteAllTasksDoneUsecase;
  late MockDeleteTasksByIdUsecase mockDeleteTasksByIdUsecase;
  late TaskModel task;

  setUp(() {
    task = TaskModel(id: 1, title: 'Task 1', description: 'Description 1');
    mockGetDoneTaskUsecase = MockGetDoneTaskUsecase();
    mockDeleteAllTasksDoneUsecase = MockDeleteAllTasksDoneUsecase();
    mockDeleteTasksByIdUsecase = MockDeleteTasksByIdUsecase();
    bloc = ListDoneTaskBloc(
      getDoneTasksUseCase: mockGetDoneTaskUsecase,
      deleteAllTasksDoneUseCase: mockDeleteAllTasksDoneUsecase,
      deleteTasksByIdUsecase: mockDeleteTasksByIdUsecase,
    );
  });

  group('ListDoneTaskBloc', () {
    test('initial state should be empty', () {
      expect(bloc.state, const ListDoneTaskState(stateEnum: StateEnum.initial));
    });

    blocTest<ListDoneTaskBloc, ListDoneTaskState>(
      'emits success state when GetCompletedTasksEvent is added',
      build: () {
        when(() => mockGetDoneTaskUsecase.call(NoParams()))
            .thenAnswer((_) async => (<TaskModel>[task], null));
        return bloc;
      },
      act: (bloc) => bloc.add(GetCompletedTasksEvent()),
      expect: () => [
        const ListDoneTaskState(stateEnum: StateEnum.loading),
        ListDoneTaskState(stateEnum: StateEnum.success, tasks: [task]),
      ],
    );

    blocTest<ListDoneTaskBloc, ListDoneTaskState>(
      'emits empty state when GetCompletedTasksEvent is added',
      build: () {
        when(() => mockGetDoneTaskUsecase.call(NoParams()))
            .thenAnswer((_) async => (<TaskModel>[], null));
        return bloc;
      },
      act: (bloc) => bloc.add(GetCompletedTasksEvent()),
      expect: () => [
        const ListDoneTaskState(stateEnum: StateEnum.loading),
        const ListDoneTaskState(stateEnum: StateEnum.empty, tasks: []),
      ],
    );

    blocTest<ListDoneTaskBloc, ListDoneTaskState>(
      'emits error state when GetCompletedTasksEvent fails',
      build: () {
        when(() => mockGetDoneTaskUsecase.call(NoParams()))
            .thenAnswer((_) async => (null, LocalStorageFailure()));
        return bloc;
      },
      act: (bloc) => bloc.add(GetCompletedTasksEvent()),
      expect: () => [
        const ListDoneTaskState(stateEnum: StateEnum.loading),
        const ListDoneTaskState(stateEnum: StateEnum.error),
      ],
    );

    blocTest<ListDoneTaskBloc, ListDoneTaskState>(
      'emits deleted state when DeleteAllTasksDone is added',
      build: () {
        when(() => mockDeleteAllTasksDoneUsecase.call(NoParams()))
            .thenAnswer((_) async => (true, null));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteAllTasksDone()),
      expect: () => [
        const ListDoneTaskState(stateEnum: StateEnum.loading),
        const ListDoneTaskState(stateEnum: StateEnum.deleted),
      ],
    );

    blocTest<ListDoneTaskBloc, ListDoneTaskState>(
      'emits deleted state when DeleteTasksById is added',
      build: () {
        when(() => mockDeleteTasksByIdUsecase.call(1))
            .thenAnswer((_) async => (true, null));
        return bloc;
      },
      act: (bloc) => bloc.add(DeleteTasksById(id: 1)),
      expect: () => [
        const ListDoneTaskState(stateEnum: StateEnum.loading),
        const ListDoneTaskState(stateEnum: StateEnum.deleted),
      ],
    );
  });
}
