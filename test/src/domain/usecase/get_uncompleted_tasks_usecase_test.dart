import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/get_uncompleted_tasks_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late GetUncompletedTasksUsecase getUncompletedTasksUsecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getUncompletedTasksUsecase =
        GetUncompletedTasksUsecase(repository: mockTaskRepository);
  });

  group('GetUncompletedTasksUsecase', () {
    test('should successfully get uncompleted tasks', () async {
      final tasksUncompleted = [
        TaskModel(title: 'Task 1', description: 'Description 1'),
        TaskModel(title: 'Task 2', description: 'Description 2'),
      ];

      when(() => mockTaskRepository.getUncompletedTasks())
          .thenAnswer((_) async => tasksUncompleted);

      final result = await getUncompletedTasksUsecase(NoParams());

      expect(result.$1, isNotNull);
      expect(result.$1?.length, equals(tasksUncompleted.length));
      expect(result.$2, isNull);

      verify(() => mockTaskRepository.getUncompletedTasks()).called(1);
    });

    test(
        'should return LocalStorageFailure when LocalStorageException is thrown',
        () async {
      when(() => mockTaskRepository.getUncompletedTasks())
          .thenThrow(LocalStorageException('Error'));

      final result = await getUncompletedTasksUsecase(NoParams());

      expect(result.$1, isNull);
      expect(result.$2, isA<LocalStorageFailure>());

      verify(() => mockTaskRepository.getUncompletedTasks()).called(1);
    });

    test('should return GenericsFailure when an unknown exception is thrown',
        () async {
      when(() => mockTaskRepository.getUncompletedTasks())
          .thenThrow(Exception());

      final result = await getUncompletedTasksUsecase(NoParams());

      expect(result.$1, isNull);
      expect(result.$2, isA<GenericsFailure>());

      verify(() => mockTaskRepository.getUncompletedTasks()).called(1);
    });
  });
}
