import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/mixins/task_listener_mixin.dart';
import 'package:taski/src/core/models/task_event.dart';
import 'package:taski/src/core/widgets/header_page.dart';
import 'package:taski/src/core/widgets/header_page_loading.dart';
import 'package:taski/src/core/widgets/state_pages/empty_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/error_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/loading_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/success_list_task_widget.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_bloc.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_event.dart';
import 'package:taski/src/features/list_task/bloc/get_quantity_tasks/get_quantity_tasks_state.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_bloc.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_event.dart';
import 'package:taski/src/features/list_task/bloc/list_tasks_uncompleted/list_task_state.dart';

class ListTaskView extends StatefulWidget {
  const ListTaskView({super.key});

  @override
  State<ListTaskView> createState() => _ListTaskViewState();
}

class _ListTaskViewState extends State<ListTaskView> with TaskListenerMixin {
  late ListTaskUncompletedBloc _taskCubit;
  late GetQuantityTaskUncompletedBloc _quantityTasksBloc;
  int quantityTasks = 0;

  @override
  void initState() {
    super.initState();

    _taskCubit = GetIt.I.get<ListTaskUncompletedBloc>();
    _quantityTasksBloc = GetIt.I.get<GetQuantityTaskUncompletedBloc>();

    _quantityTasksBloc.add(GetQuantityUncompletedTasks());
    _taskCubit.add(GetUncompletedTasksEvent());
  }

  @override
  void onTaskModified(TaskEvent event) {
    if (event.operation == TaskOperation.createOrUpdate) {
      _taskCubit.add(GetUncompletedTasksEvent());
      _quantityTasksBloc.add(GetQuantityUncompletedTasks());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: BlocBuilder<GetQuantityTaskUncompletedBloc, GetQuantityTasksState>(
        bloc: _quantityTasksBloc,
        builder: (context, quantityState) {
          quantityTasks = quantityState.quantityOfTasks;
          return BlocBuilder<ListTaskUncompletedBloc, StateListTask>(
            bloc: _taskCubit,
            builder: (context, state) {
              switch (state.stateEnum) {
                case StateEnum.empty:
                case StateEnum.notFound:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderPage(quantityTasks: quantityTasks),
                      const EmptyListTaskWidget(),
                    ],
                  );
                case StateEnum.error:
                  return ErrorListTaskWidget(
                    onPressed: () => _taskCubit.add(GetUncompletedTasksEvent()),
                  );
                case StateEnum.success:
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderPage(quantityTasks: quantityTasks),
                      Expanded(
                        child: SuccessListTaskWidget(
                          tasks: state.tasks!,
                        ),
                      ),
                    ],
                  );

                default:
                  return const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderPageLoading(),
                      Expanded(
                        child: LoadingListTaskWidget(),
                      ),
                    ],
                  );
              }
            },
          );
        },
      ),
    );
  }
}
