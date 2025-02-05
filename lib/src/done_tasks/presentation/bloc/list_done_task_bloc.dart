import 'package:bloc/bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/done_tasks/domain/usecases/delete_all_tasks_done_usecase.dart';
import 'package:taski/src/done_tasks/domain/usecases/delete_task_by_id_usecase.dart';
import 'package:taski/src/done_tasks/domain/usecases/get_done_task_usecase.dart';
import 'package:taski/src/done_tasks/presentation/bloc/list_done_task_event.dart';
import 'package:taski/src/done_tasks/presentation/bloc/list_done_task_state.dart';

class ListDoneTaskBloc extends Bloc<ListDoneTaskEvent, ListDoneTaskState> {
  final GetDoneTaskUsecase _getDoneTasksUseCase;
  final DeleteAllTasksDoneUsecase _deleteAllTasksDoneUseCase;
  final DeleteTasksByIdUsecase _deleteTasksByIdUsecase;

  ListDoneTaskBloc({
    required GetDoneTaskUsecase getDoneTasksUseCase,
    required DeleteAllTasksDoneUsecase deleteAllTasksDoneUseCase,
    required DeleteTasksByIdUsecase deleteTasksByIdUsecase,
  })  : _getDoneTasksUseCase = getDoneTasksUseCase,
        _deleteAllTasksDoneUseCase = deleteAllTasksDoneUseCase,
        _deleteTasksByIdUsecase = deleteTasksByIdUsecase,
        super(const ListDoneTaskState()) {
    on<GetCompletedTasksEvent>(_getUncompletedTasks);
    on<DeleteAllTasksDone>(_deleteAllTasksDone);
    on<DeleteTasksById>(_deleteTasksById);
  }

  Future<void> _getUncompletedTasks(
    GetCompletedTasksEvent event,
    Emitter<ListDoneTaskState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final successOrFailure = await _getDoneTasksUseCase.call(NoParams());

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

  Future<void> _deleteAllTasksDone(
    DeleteAllTasksDone event,
    Emitter<ListDoneTaskState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      await _deleteAllTasksDoneUseCase.call(NoParams());
      emit(state.copyWith(stateEnum: StateEnum.success));
    } catch (e) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }

  Future<void> _deleteTasksById(
    DeleteTasksById event,
    Emitter<ListDoneTaskState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      await _deleteTasksByIdUsecase(event.id);
      emit(state.copyWith(stateEnum: StateEnum.success));
    } catch (e) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }
}
