import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_bloc.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_event.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_state.dart';

class MockGetUncompletedTasksUsecase extends Mock
    implements GetUncompletedTasksUsecase {}

void main() {
  late ListTaskUncompletedBloc bloc;
  late MockGetUncompletedTasksUsecase mockGetUncompletedTasksUsecase;
  final List<TaskModel> listTasks = [
    TaskModel(title: 'Task 1', description: 'Description 1'),
    TaskModel(title: 'Task 2', description: 'Description 2'),
  ];

  setUp(() {
    mockGetUncompletedTasksUsecase = MockGetUncompletedTasksUsecase();
    bloc = ListTaskUncompletedBloc(usecase: mockGetUncompletedTasksUsecase);
  });

  test('initial state should be correct', () {
    expect(bloc.state, const StateListTask());
  });

  blocTest<ListTaskUncompletedBloc, StateListTask>(
    'emits [loading, success] when GetUncompletedTasksEvent is added and usecase succeeds',
    build: () {
      when(() => mockGetUncompletedTasksUsecase.call(NoParams()))
          .thenAnswer((_) async => (listTasks, null));
      return bloc;
    },
    act: (bloc) => bloc.add(GetUncompletedTasksEvent()),
    expect: () => [
      const StateListTask(stateEnum: StateEnum.loading),
      StateListTask(
        tasks: listTasks,
        stateEnum: StateEnum.success,
      ),
    ],
  );

  blocTest<ListTaskUncompletedBloc, StateListTask>(
    'emits [loading, error] when GetUncompletedTasksEvent is added and usecase fails',
    build: () {
      when(() => mockGetUncompletedTasksUsecase.call(NoParams()))
          .thenAnswer((_) async => (null, LocalStorageFailure()));
      return bloc;
    },
    act: (bloc) => bloc.add(GetUncompletedTasksEvent()),
    expect: () => [
      const StateListTask(stateEnum: StateEnum.loading),
      const StateListTask(stateEnum: StateEnum.error),
    ],
  );

  blocTest<ListTaskUncompletedBloc, StateListTask>(
    'emits [loading, empty] when GetUncompletedTasksEvent is added and usecase returns empty tasks',
    build: () {
      when(() => mockGetUncompletedTasksUsecase.call(NoParams()))
          .thenAnswer((_) async => (<TaskModel>[], null));
      return bloc;
    },
    act: (bloc) => bloc.add(GetUncompletedTasksEvent()),
    expect: () => [
      const StateListTask(stateEnum: StateEnum.loading),
      const StateListTask(stateEnum: StateEnum.empty, tasks: []),
    ],
  );
}
