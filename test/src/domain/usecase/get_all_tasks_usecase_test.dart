import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/get_all_tasks_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late GetAllTasksUsecase getAllTasksUsecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getAllTasksUsecase = GetAllTasksUsecase(repository: mockTaskRepository);
  });

  group('GetAllTasksUsecase', () {
    test('should successfully get all tasks', () async {
      final taskList = [
        TaskModel(title: 'Task 1', description: 'Description 1'),
        TaskModel(title: 'Task 2', description: 'Description 2')
      ];

      when(() => mockTaskRepository.getAllTasks())
          .thenAnswer((_) async => taskList);

      final result = await getAllTasksUsecase(NoParams());

      expect(result.$1, isNotNull);
      expect(result.$1?.length, 2);
      expect(result.$1?[0].title, 'Task 1');
      expect(result.$2, isNull);

      verify(() => mockTaskRepository.getAllTasks()).called(1);
    });

    test(
        'should return LocalStorageFailure when LocalStorageException is thrown',
        () async {
      when(() => mockTaskRepository.getAllTasks())
          .thenThrow(LocalStorageException('Error'));

      final result = await getAllTasksUsecase(NoParams());

      expect(result.$1, isNull);
      expect(result.$2, isA<LocalStorageFailure>());

      verify(() => mockTaskRepository.getAllTasks()).called(1);
    });

    test('should return GenericsFailure when an unknown exception is thrown',
        () async {
      when(() => mockTaskRepository.getAllTasks()).thenThrow(Exception());

      final result = await getAllTasksUsecase(NoParams());

      expect(result.$1, isNull);
      expect(result.$2, isA<GenericsFailure>());

      verify(() => mockTaskRepository.getAllTasks()).called(1);
    });
  });
}
