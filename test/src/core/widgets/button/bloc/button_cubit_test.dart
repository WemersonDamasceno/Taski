import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';
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
    buttonCubit.changeStatusButton(StatusButtonEnum.loading);

    expect(buttonCubit.state.statusButton, StatusButtonEnum.loading);
  });

  test('changeStatusButton should update the state correctly multiple times',
      () {
    buttonCubit.changeStatusButton(StatusButtonEnum.enable);
    buttonCubit.changeStatusButton(StatusButtonEnum.disable);

    expect(buttonCubit.state.statusButton, StatusButtonEnum.disable);
  });
}
