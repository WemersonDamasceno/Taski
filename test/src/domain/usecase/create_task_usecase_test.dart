import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/create_task_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late CreateTaskUsecase createTaskUsecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    createTaskUsecase = CreateTaskUsecase(repository: mockTaskRepository);
  });

  group('CreateTaskUsecase', () {
    test('should successfully create a task', () async {
      const task = 'Test Task';
      const note = 'Test Description';
      const params = CreateTaskParams(task: task, note: note);
      final taskModel = TaskModel(title: task, description: note);

      when(() => mockTaskRepository.insertTask(
            TaskModel(title: task, description: note),
          )).thenAnswer((_) async => Future.value(1));

      final result = await createTaskUsecase(params);

      expect(result.$1, isNotNull);
      expect(result.$1?.title, task);
      expect(result.$1?.description, note);
      expect(result.$2, isNull);

      verify(() => mockTaskRepository.insertTask(taskModel)).called(1);
    });

    test(
        'should return LocalStorageFailure when LocalStorageException is thrown',
        () async {
      const task = 'Test Task';
      const note = 'Test Description';
      const params = CreateTaskParams(task: task, note: note);

      when(() => mockTaskRepository.insertTask(
            TaskModel(title: task, description: note),
          )).thenThrow(LocalStorageException('Error'));

      final result = await createTaskUsecase(params);

      expect(result.$1, isNull);
      expect(result.$2, isA<LocalStorageFailure>());

      verify(() => mockTaskRepository.insertTask(
            TaskModel(title: task, description: note),
          )).called(1);
    });

    test('should return GenericsFailure when an unknown exception is thrown',
        () async {
      const task = 'Test Task';
      const note = 'Test Description';
      const params = CreateTaskParams(task: task, note: note);

      when(() => mockTaskRepository.insertTask(
            TaskModel(title: task, description: note),
          )).thenThrow(Exception());

      final result = await createTaskUsecase(params);

      expect(result.$1, isNull);
      expect(result.$2, isA<GenericsFailure>());

      verify(() => mockTaskRepository.insertTask(
            TaskModel(title: task, description: note),
          )).called(1);
    });
  });
}
