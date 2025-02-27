import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_event.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_state.dart';

class ListTaskUncompletedBloc extends Bloc<ListTaskEvent, StateListTask> {
  ListTaskUncompletedBloc({required GetUncompletedTasksUsecase usecase})
      : _usecase = usecase,
        super(const StateListTask()) {
    on<GetUncompletedTasksEvent>(_onGetUncompletedTasks);
  }
  final GetUncompletedTasksUsecase _usecase;

  Future<void> _onGetUncompletedTasks(
    GetUncompletedTasksEvent event,
    Emitter<StateListTask> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final result = await _usecase(NoParams());

      if (result.$2 != null) {
        emit(state.copyWith(stateEnum: StateEnum.error));
        return;
      }

      emit(
        state.copyWith(
          tasks: result.$1,
          stateEnum: result.$1!.isEmpty ? StateEnum.empty : StateEnum.success,
        ),
      );
    } catch (_) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }
}
