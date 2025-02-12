import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/widgets/state_pages/empty_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/error_list_task_widget.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_cubit.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_state.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_bloc.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_event.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_state.dart';
import 'package:taski/src/features/done_tasks/views/done_tasks_view.dart';

class MockListDoneTaskBloc
    extends MockBloc<ListDoneTaskEvent, ListDoneTaskState>
    implements ListDoneTaskBloc {}

class MockEnableDeleteButtonCubit extends MockCubit<EnableButtonState>
    implements EnableDeleteButtonCubit {}

void main() {
  late ListDoneTaskBloc mockListDoneTaskBloc;
  late MockEnableDeleteButtonCubit mockEnableButtonCubit;

  final task1 = TaskModel(id: 1, title: 'Task 1', description: 'Description 1');

  setUp(() {
    mockListDoneTaskBloc = MockListDoneTaskBloc();
    mockEnableButtonCubit = MockEnableDeleteButtonCubit();

    GetIt.I.registerSingleton<ListDoneTaskBloc>(mockListDoneTaskBloc);
    GetIt.I.registerSingleton<EnableDeleteButtonCubit>(mockEnableButtonCubit);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('Deve exibir a lista de tarefas concluídas',
      (WidgetTester tester) async {
    when(() => mockListDoneTaskBloc.state).thenReturn(
      ListDoneTaskState(stateEnum: StateEnum.success, tasks: [task1]),
    );
    when(() => mockEnableButtonCubit.state).thenReturn(
      const EnableButtonState(
        enable: true,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockListDoneTaskBloc,
          child: const DoneTasksView(),
        ),
      ),
    );

    final finderFirstItem = find.byKey(ValueKey('item-${task1.id}'));
    expect(finderFirstItem, findsOneWidget);
  });

  testWidgets('Deve exibir tela vazia quando não há tarefas',
      (WidgetTester tester) async {
    when(() => mockListDoneTaskBloc.state).thenReturn(
      const ListDoneTaskState(stateEnum: StateEnum.empty, tasks: []),
    );

    when(() => mockEnableButtonCubit.state).thenReturn(
      const EnableButtonState(enable: true),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockListDoneTaskBloc,
          child: const DoneTasksView(),
        ),
      ),
    );

    expect(find.byType(EmptyListTaskWidget), findsOneWidget);
  });

  testWidgets('Deve exibir tela de erro e permitir recarregar',
      (WidgetTester tester) async {
    when(() => mockListDoneTaskBloc.state).thenReturn(
      const ListDoneTaskState(stateEnum: StateEnum.error),
    );
    when(() => mockEnableButtonCubit.state).thenReturn(
      const EnableButtonState(enable: true),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: mockListDoneTaskBloc,
          child: const DoneTasksView(),
        ),
      ),
    );

    expect(find.byType(ErrorListTaskWidget), findsOneWidget);

    final finderRefresh = find.text(AppStrings.tryAgain);
    expect(finderRefresh, findsOneWidget);

    await tester.tap(finderRefresh);
    await tester.pump();

    verify(() => mockListDoneTaskBloc.add(GetCompletedTasksEvent())).called(2);
  });
}
