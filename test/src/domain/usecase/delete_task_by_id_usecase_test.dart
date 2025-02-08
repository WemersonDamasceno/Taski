import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/delete_task_by_id_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeleteTasksByIdUsecase deleteTasksByIdUsecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    deleteTasksByIdUsecase =
        DeleteTasksByIdUsecase(repository: mockTaskRepository);
  });

  group('DeleteTasksByIdUsecase', () {
    test('should successfully delete a task by ID', () async {
      const taskId = 1;

      when(() => mockTaskRepository.deleteTask(taskId))
          .thenAnswer((_) async => 1);

      final result = await deleteTasksByIdUsecase(taskId);

      expect(result.$1, isTrue);
      expect(result.$2, isNull);

      verify(() => mockTaskRepository.deleteTask(taskId)).called(1);
    });

    test(
        'should return LocalStorageFailure when LocalStorageException is thrown',
        () async {
      const taskId = 1;

      when(() => mockTaskRepository.deleteTask(taskId))
          .thenThrow(LocalStorageException('Error'));

      final result = await deleteTasksByIdUsecase(taskId);

      expect(result.$1, isNull);
      expect(result.$2, isA<LocalStorageFailure>());

      verify(() => mockTaskRepository.deleteTask(taskId)).called(1);
    });

    test('should return GenericsFailure when an unknown exception is thrown',
        () async {
      const taskId = 1;

      when(() => mockTaskRepository.deleteTask(taskId)).thenThrow(Exception());

      final result = await deleteTasksByIdUsecase(taskId);

      expect(result.$1, isNull);
      expect(result.$2, isA<GenericsFailure>());

      verify(() => mockTaskRepository.deleteTask(taskId)).called(1);
    });
  });
}
