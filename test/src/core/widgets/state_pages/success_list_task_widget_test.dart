import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/bloc/update_task_bloc.dart';
import 'package:taski/src/core/bloc/update_task_state.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/widgets/state_pages/success_list_task_widget.dart';

class MockUpdateTaskBloc extends Mock implements UpdateTaskBloc {}

void main() {
  late UpdateTaskBloc updateTaskBloc;
  late SuccessListTaskWidget widget;
  final task = TaskModel(id: 1, title: 'Tarefa 1', description: 'Desc');

  setUp(() async {
    updateTaskBloc = MockUpdateTaskBloc();
    widget = SuccessListTaskWidget(
      tasks: [task],
    );

    await GetIt.I.reset();
    GetIt.I.registerFactory<UpdateTaskBloc>(() => updateTaskBloc);

    whenListen(
      updateTaskBloc,
      Stream.fromIterable([
        const UpdateTaskState(),
        UpdateTaskState(
          task: task,
          stateEnum: StateEnum.success,
        ),
      ]),
      initialState: const UpdateTaskState(),
    );
  });
  group('UpdateTaskBloc', () {
    test('deve emitir sucesso ao atualizar uma tarefa', () async {
      await expectLater(
        updateTaskBloc.stream,
        emitsInOrder([
          const UpdateTaskState(),
          UpdateTaskState(
            task: task,
            stateEnum: StateEnum.success,
          ),
        ]),
      );
    });
  });

  group('SuccessListTaskWidget', () {
    testWidgets('deve exibir uma lista de tarefas', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider.value(
              value: updateTaskBloc,
              child: widget,
            ),
          ),
        ),
      );

      expect(find.text('Tarefa 1'), findsOneWidget);
    });
  });
}
