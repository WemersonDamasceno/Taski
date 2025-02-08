import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/data/repository/task_repository_impl.dart';
import 'package:taski/src/data/services/local_datastorage.dart';

class MockLocalDatabaseService extends Mock implements LocalDatabaseService {}

void main() {
  late TaskRepositoryImpl taskRepository;
  late MockLocalDatabaseService mockDatabaseService;

  setUp(() {
    mockDatabaseService = MockLocalDatabaseService();
    taskRepository = TaskRepositoryImpl(databaseService: mockDatabaseService);
  });

  group('TaskRepositoryImpl', () {
    final task = TaskModel(
      id: 1,
      title: 'Test Task',
      description: 'Description',
      isCompleted: false,
    );

    test('should return a list of uncompleted tasks', () async {
      when(() => mockDatabaseService.getUncompletedTasks()).thenAnswer(
        (_) async => [task],
      );

      final result = await taskRepository.getUncompletedTasks();

      expect(result, isA<List<TaskModel>>());
      expect(result.length, 1);
      expect(result.first, task);
      verify(() => mockDatabaseService.getUncompletedTasks()).called(1);
    });

    test('should return the quantity of uncompleted tasks', () async {
      when(() => mockDatabaseService.quantityOfUncompletedTasks()).thenAnswer(
        (_) async => 1,
      );

      final result = await taskRepository.getQuantityOfUncompletedTasks();

      expect(result, 1);
      verify(() => mockDatabaseService.quantityOfUncompletedTasks()).called(1);
    });

    test('should insert a new task', () async {
      when(() => mockDatabaseService.insertTask(task)).thenAnswer(
        (_) async => 1,
      );

      final result = await taskRepository.insertTask(task);

      expect(result, 1);
      verify(() => mockDatabaseService.insertTask(task)).called(1);
    });

    test('should delete a task by id', () async {
      when(() => mockDatabaseService.deleteTask(1)).thenAnswer(
        (_) async => 1,
      );

      final result = await taskRepository.deleteTask(1);

      expect(result, 1);
      verify(() => mockDatabaseService.deleteTask(1)).called(1);
    });

    test('should return a list of completed tasks', () async {
      when(() => mockDatabaseService.getCompletedTasks()).thenAnswer(
        (_) async => [task],
      );

      final result = await taskRepository.getDoneTasks();

      expect(result, isA<List<TaskModel>>());
      expect(result.length, 1);
      expect(result.first, task);
      verify(() => mockDatabaseService.getCompletedTasks()).called(1);
    });

    test('should return tasks filtered by title', () async {
      when(() => mockDatabaseService.getTasksByTitle('Test')).thenAnswer(
        (_) async => [task],
      );

      final result = await taskRepository.getTasksByTitle('Test');

      expect(result, isA<List<TaskModel>>());
      expect(result.length, 1);
      expect(result.first, task);
      verify(() => mockDatabaseService.getTasksByTitle('Test')).called(1);
    });

    test('should update a task', () async {
      when(() => mockDatabaseService.updateTask(task)).thenAnswer(
        (_) async => 1,
      );

      final result = await taskRepository.updateTask(task);

      expect(result, 1);
      verify(() => mockDatabaseService.updateTask(task)).called(1);
    });

    test('should delete all completed tasks', () async {
      when(() => mockDatabaseService.deleteAllDoneTasks()).thenAnswer(
        (_) async => 1,
      );

      final result = await taskRepository.deleteAllDoneTasks();

      expect(result, 1);
      verify(() => mockDatabaseService.deleteAllDoneTasks()).called(1);
    });

    test('should return a list of all tasks', () async {
      when(() => mockDatabaseService.getAllTasks()).thenAnswer(
        (_) async => [task],
      );

      final result = await taskRepository.getAllTasks();

      expect(result, isA<List<TaskModel>>());
      expect(result.length, 1);
      expect(result.first, task);
      verify(() => mockDatabaseService.getAllTasks()).called(1);
    });
  });
}
