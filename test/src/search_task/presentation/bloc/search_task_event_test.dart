import 'package:flutter_test/flutter_test.dart';
import 'package:taski/src/search_task/presentation/bloc/search_task_event.dart';

void main() {
  group('SearchTaskEvent Tests', () {
    test('SearchTaskByTitleEvent should be equal when the title is the same',
        () {
      expect(SearchTaskByTitleEvent('task1'), SearchTaskByTitleEvent('task1'));
    });

    test('CleanInputEvent should be equal always', () {
      expect(CleanInputEvent(), CleanInputEvent());
    });
  });
}
