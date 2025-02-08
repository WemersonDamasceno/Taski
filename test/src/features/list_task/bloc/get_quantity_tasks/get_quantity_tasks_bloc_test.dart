import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/usecase/get_quantity_uncompleted_tasks_usecase.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_bloc.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_event.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_state.dart';

class MockGetQuantityUncompltedTaskUsecase extends Mock
    implements GetQuantityUncompltedTaskUsecase {}

void main() {
  late GetQuantityTaskUncompletedBloc bloc;
  late MockGetQuantityUncompltedTaskUsecase mockUsecase;

  setUp(() {
    mockUsecase = MockGetQuantityUncompltedTaskUsecase();
    bloc = GetQuantityTaskUncompletedBloc(usecase: mockUsecase);
  });

  test('initial state is correct', () {
    expect(bloc.state, const GetQuantityTasksState());
  });

  group('GetQuantityUncompletedTasks event', () {
    test('emits success state with quantity of tasks', () async {
      when(() => mockUsecase.call(NoParams()))
          .thenAnswer((_) async => (5, null));

      bloc.add(GetQuantityUncompletedTasks());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const GetQuantityTasksState(stateEnum: StateEnum.loading),
          const GetQuantityTasksState(
            quantityOfTasks: 5,
            stateEnum: StateEnum.success,
          ),
        ]),
      );
    });

    test('emits error state when usecase returns failure', () async {
      when(() => mockUsecase.call(NoParams()))
          .thenAnswer((_) async => (null, LocalStorageFailure()));

      bloc.add(GetQuantityUncompletedTasks());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const GetQuantityTasksState(stateEnum: StateEnum.loading),
          const GetQuantityTasksState(stateEnum: StateEnum.error),
        ]),
      );
    });

    test('emits error state when an exception occurs', () async {
      when(() => mockUsecase.call(NoParams())).thenThrow(Exception());

      bloc.add(GetQuantityUncompletedTasks());

      await expectLater(
        bloc.stream,
        emitsInOrder([
          const GetQuantityTasksState(stateEnum: StateEnum.loading),
          const GetQuantityTasksState(stateEnum: StateEnum.error),
        ]),
      );
    });
  });
}
