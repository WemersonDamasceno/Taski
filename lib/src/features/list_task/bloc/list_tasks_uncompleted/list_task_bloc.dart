import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/domain/usecase/get_uncompleted_tasks_usecase.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_event.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_state.dart';

class ListTaskUncompletedBloc extends Bloc<ListTaskEvent, StateListTask> {
  final GetUncompletedTasksUsecase _usecase;

  ListTaskUncompletedBloc({required GetUncompletedTasksUsecase usecase})
      : _usecase = usecase,
        super(const StateListTask()) {
    on<GetPagedUncompletedTasksEvent>(_onGetUncompletedTasks);
  }

  Future<void> _onGetUncompletedTasks(
    GetPagedUncompletedTasksEvent event,
    Emitter<StateListTask> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final result = await _usecase(GetTasksPaginationParams(
        limit: event.limit,
        offset: event.offset,
      ));

      await Future.delayed(const Duration(seconds: 1));

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
