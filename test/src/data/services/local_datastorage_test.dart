import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sqflite/sqflite.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/data/services/database_provider.dart';
import 'package:taski/src/data/services/local_datastorage.dart';

class MockDatabaseProvider extends Mock implements DatabaseProvider {}

class MockDatabase extends Mock implements Database {}

void main() {
  late MockDatabaseProvider mockDatabaseProvider;
  late LocalDatabaseServiceImpl localDatabaseService;
  late MockDatabase mockDatabase;

  setUp(() {
    mockDatabaseProvider = MockDatabaseProvider();
    mockDatabase = MockDatabase();
    localDatabaseService =
        LocalDatabaseServiceImpl(databaseProvider: mockDatabaseProvider);
  });

  group('LocalDatabaseService', () {
    test('should insert a task into the database', () async {
      when(() => mockDatabaseProvider.database)
          .thenAnswer((_) async => mockDatabase);
      when(() => mockDatabase.insert(any(), any())).thenAnswer((_) async => 1);

      final task = TaskModel(
        id: null,
        title: 'Test Task',
        description: 'Test Description',
      );

      final result = await localDatabaseService.insertTask(task);

      expect(result, 1);
      verify(() => mockDatabase.insert('tasks', task.toMap())).called(1);
    });

    test('should retrieve uncompleted tasks from the database', () async {
      when(() => mockDatabaseProvider.database)
          .thenAnswer((_) async => mockDatabase);
      when(() => mockDatabase.query(
            'tasks',
            where: 'isCompleted = ?',
            whereArgs: [0],
          )).thenAnswer((_) async => [
            {
              'id': 1,
              'title': 'Test Task',
              'description': 'Test Description',
              'isCompleted': 0
            }
          ]);

      final result = await localDatabaseService.getUncompletedTasks();

      expect(result.length, 1);
      expect(result.first.title, 'Test Task');
      verify(() => mockDatabase
          .query('tasks', where: 'isCompleted = ?', whereArgs: [0])).called(1);
    });

    test('should delete a task from the database', () async {
      when(() => mockDatabaseProvider.database)
          .thenAnswer((_) async => mockDatabase);
      when(() => mockDatabase.delete(
            'tasks',
            where: 'id = ?',
            whereArgs: [1],
          )).thenAnswer((_) async => 1);

      final result = await localDatabaseService.deleteTask(1);

      expect(result, 1);
      verify(() =>
              mockDatabase.delete('tasks', where: 'id = ?', whereArgs: [1]))
          .called(1);
    });

    test('should return the quantity of uncompleted tasks', () async {
      when(() => mockDatabaseProvider.database)
          .thenAnswer((_) async => mockDatabase);
      when(() => mockDatabase.rawQuery(
              'SELECT COUNT(*) as total FROM tasks WHERE isCompleted = 0'))
          .thenAnswer((_) async => [
                {'total': 5}
              ]);

      final result = await localDatabaseService.quantityOfUncompletedTasks();

      expect(result, 5);
      verify(() => mockDatabase.rawQuery(
              'SELECT COUNT(*) as total FROM tasks WHERE isCompleted = 0'))
          .called(1);
    });
  });
}
