import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_state.dart';

void main() {
  group('EnableButtonState', () {
    test('should compare two EnableButtonState objects based on enable', () {
      const state1 = EnableButtonState(enable: true);
      const state2 = EnableButtonState(enable: true);
      const state3 = EnableButtonState(enable: false);

      expect(state1, state2);
      expect(state1, isNot(state3));
    });

    test('should return the correct value of enable', () {
      const state = EnableButtonState(enable: true);

      expect(state.enable, true);
    });
  });
}
