import 'package:bloc/bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/list_task/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/list_task/presentation/bloc/list_task_event.dart';
import 'package:taski/src/list_task/presentation/bloc/list_task_state.dart';

class ListTaskBloc extends Bloc<ListTaskEvent, StateListTask> {
  final FetchTasksUseCase _fetchTasksUseCase;

  ListTaskBloc({required FetchTasksUseCase fetchTasksUseCase})
      : _fetchTasksUseCase = fetchTasksUseCase,
        super(StateListTask()) {
    on<GetUncompletedTasksEvent>(getUncompletedTasks);
  }

  Future<void> getUncompletedTasks(
    GetUncompletedTasksEvent event,
    Emitter<StateListTask> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final successOrFailure = await _fetchTasksUseCase.call(NoParams());

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
