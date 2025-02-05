import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/list_task/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/search_task/domain/usecase/search_task_by_title_usecase.dart';
import 'package:taski/src/search_task/presentation/bloc/search_task_bloc.dart';
import 'package:taski/src/search_task/presentation/bloc/search_task_event.dart';
import 'package:taski/src/search_task/presentation/bloc/search_task_state.dart';

class MockFetchTasksUseCase extends Mock implements FetchTasksUseCase {}

class MockSearchTasksByTitleUseCase extends Mock
    implements SearchTasksByTitleUseCase {}

void main() {
  late SearchTaskBloc searchTaskBloc;
  late MockFetchTasksUseCase mockFetchTasksUseCase;
  late MockSearchTasksByTitleUseCase mockSearchTasksByTitleUseCase;

  setUp(() {
    mockFetchTasksUseCase = MockFetchTasksUseCase();
    mockSearchTasksByTitleUseCase = MockSearchTasksByTitleUseCase();
    searchTaskBloc = SearchTaskBloc(
      fetchTasksUseCase: mockFetchTasksUseCase,
      searchTasksByTitleUseCase: mockSearchTasksByTitleUseCase,
    );
  });

  tearDown(() {
    searchTaskBloc.close();
  });

  group('SearchTaskBloc Tests', () {
    final mockTasks = [
      TaskModel(
        id: 1,
        title: 'Task 1',
        description: 'Description',
        isCompleted: false,
      )
    ];

    blocTest<SearchTaskBloc, SearchTasksState>(
      'emits [loading, success] when SearchTaskByTitleEvent is added and returns tasks',
      build: () {
        when(() => mockSearchTasksByTitleUseCase(
            const SearchTaskParams(title: 'Task'))).thenAnswer(
          (_) async => (mockTasks, null),
        );
        return searchTaskBloc;
      },
      act: (bloc) => bloc.add(SearchTaskByTitleEvent('Task')),
      expect: () => [
        const SearchTasksState(stateEnum: StateEnum.loading),
        SearchTasksState(tasks: mockTasks, stateEnum: StateEnum.success),
      ],
    );

    blocTest<SearchTaskBloc, SearchTasksState>(
      'emits [loading, notFound] when SearchTaskByTitleEvent is added and no tasks found',
      build: () {
        when(() => mockSearchTasksByTitleUseCase(
            const SearchTaskParams(title: 'Task'))).thenAnswer(
          (_) async => (<TaskModel>[], null),
        );
        return searchTaskBloc;
      },
      act: (bloc) => bloc.add(SearchTaskByTitleEvent('Task')),
      expect: () => [
        const SearchTasksState(stateEnum: StateEnum.loading),
        const SearchTasksState(stateEnum: StateEnum.notFound),
      ],
    );

    blocTest<SearchTaskBloc, SearchTasksState>(
      'emits [loading, error] when SearchTaskByTitleEvent fails',
      build: () {
        when(() => mockSearchTasksByTitleUseCase(
            const SearchTaskParams(title: 'Task'))).thenThrow(Exception());
        return searchTaskBloc;
      },
      act: (bloc) => bloc.add(SearchTaskByTitleEvent('Task')),
      expect: () => [
        const SearchTasksState(stateEnum: StateEnum.loading),
        const SearchTasksState(stateEnum: StateEnum.error),
      ],
    );

    blocTest<SearchTaskBloc, SearchTasksState>(
      'emits [loading, success] when CleanInputEvent is added and returns tasks',
      build: () {
        when(() => mockFetchTasksUseCase(NoParams()))
            .thenAnswer((_) async => (mockTasks, null));
        return searchTaskBloc;
      },
      act: (bloc) => bloc.add(CleanInputEvent()),
      expect: () => [
        const SearchTasksState(stateEnum: StateEnum.loading),
        SearchTasksState(tasks: mockTasks, stateEnum: StateEnum.success),
      ],
    );
  });
}
