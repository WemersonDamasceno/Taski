import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/get_quantity_uncompleted_tasks_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late GetQuantityUncompltedTaskUsecase getQuantityUncompltedTaskUsecase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    getQuantityUncompltedTaskUsecase =
        GetQuantityUncompltedTaskUsecase(repository: mockTaskRepository);
  });

  group('GetQuantityUncompltedTaskUsecase', () {
    test('should successfully get quantity of uncompleted tasks', () async {
      const quantity = 5;

      when(() => mockTaskRepository.getQuantityOfUncompletedTasks())
          .thenAnswer((_) async => quantity);

      final result = await getQuantityUncompltedTaskUsecase(NoParams());

      expect(result.$1, equals(quantity));
      expect(result.$2, isNull);

      verify(() => mockTaskRepository.getQuantityOfUncompletedTasks())
          .called(1);
    });

    test(
        'should return LocalStorageFailure when LocalStorageException is thrown',
        () async {
      when(() => mockTaskRepository.getQuantityOfUncompletedTasks())
          .thenThrow(LocalStorageException('Error'));

      final result = await getQuantityUncompltedTaskUsecase(NoParams());

      expect(result.$1, isNull);
      expect(result.$2, isA<LocalStorageFailure>());

      verify(() => mockTaskRepository.getQuantityOfUncompletedTasks())
          .called(1);
    });

    test('should return GenericsFailure when an unknown exception is thrown',
        () async {
      when(() => mockTaskRepository.getQuantityOfUncompletedTasks())
          .thenThrow(Exception());

      final result = await getQuantityUncompltedTaskUsecase(NoParams());

      expect(result.$1, isNull);
      expect(result.$2, isA<GenericsFailure>());

      verify(() => mockTaskRepository.getQuantityOfUncompletedTasks())
          .called(1);
    });
  });
}
