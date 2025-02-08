import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/update_task_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late UpdateTaskUsecase updateTaskUsecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    updateTaskUsecase = UpdateTaskUsecase(repository: mockTaskRepository);
  });

  group('UpdateTaskUsecase', () {
    test('should successfully update a task', () async {
      final task =
          TaskModel(title: 'Updated Task', description: 'Updated Description');

      when(() => mockTaskRepository.updateTask(task))
          .thenAnswer((_) async => Future.value(1));

      final result = await updateTaskUsecase(task);

      expect(result.$1, equals(task));
      expect(result.$2, isNull);

      verify(() => mockTaskRepository.updateTask(task)).called(1);
    });

    test(
        'should return LocalStorageFailure when LocalStorageException is thrown',
        () async {
      final task =
          TaskModel(title: 'Updated Task', description: 'Updated Description');

      when(() => mockTaskRepository.updateTask(task))
          .thenThrow(LocalStorageException('Error'));

      final result = await updateTaskUsecase(task);

      expect(result.$1, isNull);
      expect(result.$2, isA<LocalStorageFailure>());

      verify(() => mockTaskRepository.updateTask(task)).called(1);
    });

    test('should return GenericsFailure when an unknown exception is thrown',
        () async {
      final task =
          TaskModel(title: 'Updated Task', description: 'Updated Description');

      when(() => mockTaskRepository.updateTask(task)).thenThrow(Exception());

      final result = await updateTaskUsecase(task);

      expect(result.$1, isNull);
      expect(result.$2, isA<GenericsFailure>());

      verify(() => mockTaskRepository.updateTask(task)).called(1);
    });
  });
}
