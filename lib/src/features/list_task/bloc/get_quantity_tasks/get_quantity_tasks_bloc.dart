import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/usecase/usecase.dart';
import 'package:taski/src/domain/usecase/get_quantity_uncompleted_tasks_usecase.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_event.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_state.dart';

class GetQuantityTaskUncompletedBloc
    extends Bloc<GetQuantityTasksEvent, GetQuantityTasksState> {
  final GetQuantityUncompltedTaskUsecase _usecase;

  GetQuantityTaskUncompletedBloc(
      {required GetQuantityUncompltedTaskUsecase usecase})
      : _usecase = usecase,
        super(const GetQuantityTasksState()) {
    on<GetQuantityUncompletedTasks>(_onGetQuantityUncompletedTasks);
  }

  Future<void> _onGetQuantityUncompletedTasks(
    GetQuantityUncompletedTasks event,
    Emitter<GetQuantityTasksState> emit,
  ) async {
    emit(state.copyWith(stateEnum: StateEnum.loading));
    try {
      final result = await _usecase(NoParams());
      await Future.delayed(const Duration(seconds: 1));

      if (result.$2 != null) {
        emit(state.copyWith(stateEnum: StateEnum.error));
        return;
      }

      emit(state.copyWith(
        quantityOfTasks: result.$1,
        stateEnum: StateEnum.success,
      ));
    } catch (_) {
      emit(state.copyWith(stateEnum: StateEnum.error));
    }
  }
}
