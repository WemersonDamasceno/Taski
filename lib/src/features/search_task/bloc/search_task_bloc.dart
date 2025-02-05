import 'package:bloc/bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/domain/usecase/search_task_by_title_usecase.dart';
import 'package:taski/src/features/search_task/bloc/search_task_event.dart';
import 'package:taski/src/features/search_task/bloc/search_task_state.dart';

class SearchTaskBloc extends Bloc<SearchTaskEvent, SearchTasksState> {
  final FetchTasksUseCase _fetchTasksUseCase;
  final SearchTasksByTitleUseCase _searchTasksByTitleUseCase;

  SearchTaskBloc({
    required FetchTasksUseCase fetchTasksUseCase,
    required SearchTasksByTitleUseCase searchTasksByTitleUseCase,
  })  : _fetchTasksUseCase = fetchTasksUseCase,
        _searchTasksByTitleUseCase = searchTasksByTitleUseCase,
        super(const SearchTasksState()) {
    on<SearchTaskByTitleEvent>(searchTaskByTitle);
    on<CleanInputEvent>(getAllTasks);
  }

  Future<void> searchTaskByTitle(
    SearchTaskByTitleEvent event,
    Emitter<SearchTasksState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final successOrFailure = await _searchTasksByTitleUseCase(
        SearchTaskParams(title: event.title),
      );

      if (successOrFailure.$2 != null) {
        emit(state.copyWith(stateEnum: StateEnum.error));
        return;
      }

      emit(state.copyWith(
        tasks: List.from(successOrFailure.$1!),
        stateEnum: successOrFailure.$1!.isNotEmpty
            ? StateEnum.success
            : StateEnum.notFound,
      ));
    } catch (e) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }

  Future<void> getAllTasks(
    CleanInputEvent event,
    Emitter<SearchTasksState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final successOrFailure = await _fetchTasksUseCase(NoParams());

      if (successOrFailure.$2 != null) {
        return emit(state.copyWith(stateEnum: StateEnum.error));
      }

      emit(state.copyWith(
        tasks: successOrFailure.$1,
        stateEnum: successOrFailure.$1!.isNotEmpty
            ? StateEnum.success
            : StateEnum.empty,
      ));
    } catch (e) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }
}
