import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_cubit.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_state.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_bloc.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_state.dart';
import 'package:taski/src/features/done_tasks/views/done_tasks_page.dart';
import 'package:taski/src/features/done_tasks/views/done_tasks_view.dart';

class MockListDoneTaskBloc extends Mock implements ListDoneTaskBloc {}

class MockEnableDeleteButtonCubit extends Mock
    implements EnableDeleteButtonCubit {}

void main() {
  late MockListDoneTaskBloc mockListDoneTaskBloc;
  late EnableDeleteButtonCubit mockEnableDeleteButtonCubit;

  setUp(() {
    mockListDoneTaskBloc = MockListDoneTaskBloc();
    mockEnableDeleteButtonCubit = MockEnableDeleteButtonCubit();
    GetIt.I.registerSingleton<ListDoneTaskBloc>(mockListDoneTaskBloc);
    GetIt.I.registerSingleton<EnableDeleteButtonCubit>(
      mockEnableDeleteButtonCubit,
    );
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('Deve renderizar DoneTasksPage corretamente',
      (WidgetTester tester) async {
    whenListen(
      mockListDoneTaskBloc,
      initialState: const ListDoneTaskState(stateEnum: StateEnum.initial),
      Stream<ListDoneTaskState>.fromIterable([
        ListDoneTaskState(
          stateEnum: StateEnum.success,
          tasks: [
            TaskModel(id: 1, title: 'Task 1', description: 'Description 1'),
          ],
        ),
      ]),
    );
    whenListen(
      mockEnableDeleteButtonCubit,
      initialState: const EnableButtonState(enable: true),
      Stream<EnableButtonState>.fromIterable(
        [const EnableButtonState(enable: true)],
      ),
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: DoneTasksPage(),
      ),
    );

    expect(find.byType(DoneTasksView), findsOneWidget);
  });
}
