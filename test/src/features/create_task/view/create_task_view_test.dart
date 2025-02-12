import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';
import 'package:taski/src/core/widgets/button/bloc/button_cubit.dart';
import 'package:taski/src/core/widgets/button/bloc/button_state.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';
import 'package:taski/src/features/create_task/bloc/create_task_bloc.dart';
import 'package:taski/src/features/create_task/bloc/create_task_state.dart';
import 'package:taski/src/features/create_task/view/create_task_view.dart';

class MockCreateTaskBloc extends Mock implements CreateTaskBloc {}

class MockButtonCubit extends Mock implements ButtonCubit {}

void main() {
  late MockCreateTaskBloc mockCreateTaskBloc;
  late MockButtonCubit mockButtonCubit;

  setUp(() {
    mockCreateTaskBloc = MockCreateTaskBloc();
    mockButtonCubit = MockButtonCubit();

    GetIt.I.registerSingleton<CreateTaskBloc>(mockCreateTaskBloc);
    GetIt.I.registerSingleton<ButtonCubit>(mockButtonCubit);
  });

  tearDown(() {
    GetIt.I.reset();
  });

  testWidgets('Deve exibir o BottomSheet corretamente',
      (WidgetTester tester) async {
    whenListen(
      mockCreateTaskBloc,
      initialState: const CreateTaskState(stateEnum: StateEnum.initial),
      Stream.fromIterable([
        const CreateTaskState(stateEnum: StateEnum.success),
      ]),
    );

    whenListen(
      mockButtonCubit,
      initialState: const ButtonState(statusButton: StatusButtonEnum.enable),
      Stream.fromIterable([
        const ButtonState(statusButton: StatusButtonEnum.disable),
      ]),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return Scaffold(
                body: Center(
                  child: AppButtonWidget.textButton(
                    label: 'Abrir BottomSheet',
                    onPressed: () {
                      CreateTaskView.showBottomSheet(context);
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );

    await tester.tap(find.text('Abrir BottomSheet'));
    await tester.pumpAndSettle();
  });
}
