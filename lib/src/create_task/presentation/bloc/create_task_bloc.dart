import 'package:bloc/bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/create_task/domain/usecase/create_task_usecase.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_event.dart';
import 'package:taski/src/create_task/presentation/bloc/create_task_state.dart';

class CreateTaskBloc extends Bloc<CreateTaskEvent, CreateTaskState> {
  final CreateTaskUsecase _createTaskUsecase;

  CreateTaskBloc({required CreateTaskUsecase createTaskUsecase})
      : _createTaskUsecase = createTaskUsecase,
        super(const CreateTaskState()) {
    on<CreateTask>(_createTask);
  }

  Future<void> _createTask(
    CreateTask event,
    Emitter<CreateTaskState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final successOrFailure = await _createTaskUsecase();

      if (successOrFailure.$2 != null) {
        return emit(state.copyWith(stateEnum: StateEnum.error));
      }

      emit(state.copyWith(stateEnum: StateEnum.success));
    } catch (e) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }
}
