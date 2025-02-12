import 'package:flutter_test/flutter_test.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/widgets/button/bloc/button_cubit.dart';
import 'package:taski/src/core/widgets/button/bloc/button_state.dart';

void main() {
  late ButtonCubit buttonCubit;

  setUp(() {
    buttonCubit = ButtonCubit();
  });

  tearDown(() {
    buttonCubit.close();
  });

  test('Initial state should be ButtonState with default values', () {
    expect(buttonCubit.state, const ButtonState());
  });

  test('changeStatusButton should update the statusButton in the state', () {
    buttonCubit.changeStatusButton(UIStatusButton.loading);

    expect(buttonCubit.state.statusButton, UIStatusButton.loading);
  });

  test('changeStatusButton should update the state correctly multiple times',
      () {
    buttonCubit.changeStatusButton(UIStatusButton.enable);
    buttonCubit.changeStatusButton(UIStatusButton.disable);

    expect(buttonCubit.state.statusButton, UIStatusButton.disable);
  });
}
