import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_cubit.dart';

void main() {
  group('EnableDeleteButtonCubit', () {
    late EnableDeleteButtonCubit cubit;

    setUp(() {
      cubit = EnableDeleteButtonCubit();
    });

    test('should emit true when initialized', () {
      expect(cubit.state, true);
    });

    test('should change state to false when changeState is called with false',
        () {
      cubit.changeState(false);

      expect(cubit.state, false);
    });

    test('should change state to true when changeState is called with true',
        () {
      cubit.changeState(true);

      expect(cubit.state, true);
    });
  });
}
