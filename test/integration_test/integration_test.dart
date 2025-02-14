import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:taski/main.dart' as app;
import 'package:taski/main.dart';
import 'package:taski/src/core/constants/app_constants.dart';

void main() {
  kIsTestMode = true;
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  final openCreateTask = find.byKey(AppConstants.openCreateTask);
  final taskInput = find.byKey(AppConstants.taskInput);
  final noteInput = find.byKey(AppConstants.noteInput);
  final createTaskButton = find.byKey(AppConstants.createTaskButton);

  setUpAll(() async {
    databaseFactory = databaseFactoryFfi;
    await databaseFactory.deleteDatabase(AppConstants.databaseName);
  });

  testWidgets('Should create a task', (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();

    await tester.tap(openCreateTask.first);
    await tester.pumpAndSettle();

    await tester.enterText(taskInput, 'Task 1');
    await tester.pumpAndSettle();

    await tester.enterText(noteInput, 'Description 1');
    await tester.pumpAndSettle();

    await tester.tap(createTaskButton.first);
    await tester.pumpAndSettle();

    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Description 1'), findsOneWidget);
  });
}
