import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/delete_all_tasks_done_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late DeleteAllTasksDoneUsecase deleteAllTasksDoneUsecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    deleteAllTasksDoneUsecase =
        DeleteAllTasksDoneUsecase(repository: mockTaskRepository);
  });

  group('DeleteAllTasksDoneUsecase', () {
    test('should successfully delete all completed tasks', () async {
      when(() => mockTaskRepository.deleteAllDoneTasks())
          .thenAnswer((_) async => 1);

      final result = await deleteAllTasksDoneUsecase(NoParams());

      expect(result.$1, isTrue);
      expect(result.$2, isNull);

      verify(() => mockTaskRepository.deleteAllDoneTasks()).called(1);
    });

    test(
        'should return LocalStorageFailure when LocalStorageException is thrown',
        () async {
      when(() => mockTaskRepository.deleteAllDoneTasks())
          .thenThrow(LocalStorageException('Error'));

      final result = await deleteAllTasksDoneUsecase(NoParams());

      expect(result.$1, isNull);
      expect(result.$2, isA<LocalStorageFailure>());

      verify(() => mockTaskRepository.deleteAllDoneTasks()).called(1);
    });

    test('should return GenericsFailure when an unknown exception is thrown',
        () async {
      when(() => mockTaskRepository.deleteAllDoneTasks())
          .thenThrow(Exception());

      final result = await deleteAllTasksDoneUsecase(NoParams());

      expect(result.$1, isNull);
      expect(result.$2, isA<GenericsFailure>());

      verify(() => mockTaskRepository.deleteAllDoneTasks()).called(1);
    });
  });
}
