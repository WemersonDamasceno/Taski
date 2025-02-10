import 'package:bloc/bloc.dart';
import 'package:taski/src/core/bloc/update_task_event.dart';
import 'package:taski/src/core/bloc/update_task_state.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/domain/usecase/update_task_usecase.dart';

class UpdateTaskBloc extends Bloc<UpdateTaskEvent, UpdateTaskState> {
  UpdateTaskBloc({required UpdateTaskUsecase updateTaskUsecase})
      : _updateTaskUseCase = updateTaskUsecase,
        super(const UpdateTaskState()) {
    on<UpdateTask>(_updateTask);
  }
  final UpdateTaskUsecase _updateTaskUseCase;

  Future<void> _updateTask(
    UpdateTask event,
    Emitter<UpdateTaskState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final successOrFailure = await _updateTaskUseCase.call(event.taskModel);

      if (successOrFailure.$2 != null) {
        return emit(state.copyWith(stateEnum: StateEnum.error));
      }

      emit(
        state.copyWith(
          task: successOrFailure.$1,
          stateEnum: StateEnum.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }
}
