import 'package:bloc/bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/domain/usecase/create_task_usecase.dart';
import 'package:taski/src/features/create_task/bloc/create_task_event.dart';
import 'package:taski/src/features/create_task/bloc/create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  CreateTaskBloc({required CreateTaskUsecase createTaskUsecase})
      : _createTaskUsecase = createTaskUsecase,
        super(const CreateTaskState()) {
    on<CreateTask>(_createTask);
  }
  final CreateTaskUsecase _createTaskUsecase;

  Future<void> _createTask(
    CreateTask event,
    Emitter<CreateTaskState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final successOrFailure = await _createTaskUsecase(
        CreateTaskParams(task: event.task, note: event.note),
      );

      if (successOrFailure.$2 != null) {
        return emit(state.copyWith(stateEnum: StateEnum.error));
      }

      emit(
        state.copyWith(
          taskCreated: successOrFailure.$1,
          stateEnum: StateEnum.success,
        ),
      );
    } catch (e) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }
}
