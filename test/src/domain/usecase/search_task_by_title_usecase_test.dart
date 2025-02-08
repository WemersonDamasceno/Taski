import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:taski/src/core/erros/exceptions.dart';
import 'package:taski/src/core/erros/failures.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/domain/repository/list_task_repository.dart';
import 'package:taski/src/domain/usecase/search_task_by_title_usecase.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late MockTaskRepository mockTaskRepository;
  late SearchTasksByTitleUseCase searchTasksByTitleUseCase;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    searchTasksByTitleUseCase =
        SearchTasksByTitleUseCase(repository: mockTaskRepository);
  });

  group('SearchTasksByTitleUseCase', () {
    test('should successfully search tasks by title', () async {
      const title = 'Test Task';
      const params = SearchTaskParams(title: title);
      final tasks = [
        TaskModel(title: 'Test Task', description: 'Description 1'),
        TaskModel(title: 'Test Task', description: 'Description 2'),
      ];

      when(() => mockTaskRepository.getTasksByTitle(title))
          .thenAnswer((_) async => tasks);

      final result = await searchTasksByTitleUseCase(params);

      expect(result.$1, isNotNull);
      expect(result.$1?.length, equals(tasks.length));
      expect(result.$2, isNull);

      verify(() => mockTaskRepository.getTasksByTitle(title)).called(1);
    });

    test(
        'should return LocalStorageFailure when LocalStorageException is thrown',
        () async {
      const title = 'Test Task';
      const params = SearchTaskParams(title: title);

      when(() => mockTaskRepository.getTasksByTitle(title))
          .thenThrow(LocalStorageException('Error'));

      final result = await searchTasksByTitleUseCase(params);

      expect(result.$1, isNull);
      expect(result.$2, isA<LocalStorageFailure>());

      verify(() => mockTaskRepository.getTasksByTitle(title)).called(1);
    });

    test('should return GenericsFailure when an unknown exception is thrown',
        () async {
      const title = 'Test Task';
      const params = SearchTaskParams(title: title);

      when(() => mockTaskRepository.getTasksByTitle(title))
          .thenThrow(Exception());

      final result = await searchTasksByTitleUseCase(params);

      expect(result.$1, isNull);
      expect(result.$2, isA<GenericsFailure>());

      verify(() => mockTaskRepository.getTasksByTitle(title)).called(1);
    });
  });
}
