import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/core/enums/status_button_enum.dart';
import 'package:taski/src/core/widgets/button/bloc/button_state.dart';

void main() {
  test(
      'ButtonState should have default statusButton as StatusButtonEnum.disable',
      () {
    const state = ButtonState();
    expect(state.statusButton, StatusButtonEnum.disable);
  });

  test(
      'ButtonState copyWith should return a new state with updated statusButton',
      () {
    const state = ButtonState();

    final newState = state.copyWith(statusButton: StatusButtonEnum.loading);

    expect(newState.statusButton, StatusButtonEnum.loading);
    expect(newState, isNot(equals(state)));
  });

  test(
      'ButtonState copyWith should return the same state if no new value is passed for statusButton',
      () {
    const state = ButtonState();

    final newState = state.copyWith();

    expect(newState, equals(state));
  });

  test('ButtonState should correctly compare equality', () {
    const state1 = ButtonState(statusButton: StatusButtonEnum.enable);
    const state2 = ButtonState(statusButton: StatusButtonEnum.enable);
    const state3 = ButtonState(statusButton: StatusButtonEnum.loading);

    expect(state1, equals(state2));
    expect(state1, isNot(equals(state3)));
  });
}
