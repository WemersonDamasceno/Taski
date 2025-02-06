import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/mixins/task_listener_mixin.dart';
import 'package:taski/src/core/models/task_event.dart';
import 'package:taski/src/core/widgets/state_pages/empty_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/error_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/loading_list_task_widget.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task_bloc.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task_event.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task_state.dart';
import 'package:taski/src/features/done_tasks/widgets/header_done_tasks_widget.dart';
import 'package:taski/src/features/done_tasks/widgets/task_item_done_widget.dart';

class CompletedTasksView extends StatefulWidget {
  const CompletedTasksView({super.key});

  @override
  State<CompletedTasksView> createState() => _CompletedTasksViewState();
}

class _CompletedTasksViewState extends State<CompletedTasksView>
    with TaskListenerMixin {
  late ListDoneTaskBloc _doneTasksBloc;

  @override
  void initState() {
    super.initState();
    _doneTasksBloc = GetIt.I.get<ListDoneTaskBloc>();
    _doneTasksBloc.add(GetCompletedTasksEvent());
  }

  @override
  void onTaskModified(TaskEvent event) {
    if (event.operation == TaskOperation.createOrUpdate) {
      _doneTasksBloc.add(GetCompletedTasksEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        children: [
          HeaderCompletedTasks(
            onPressed: () {
              _doneTasksBloc.add(DeleteAllTasksDone());
            },
          ),
          Expanded(
            child: BlocBuilder<ListDoneTaskBloc, ListDoneTaskState>(
              bloc: _doneTasksBloc,
              builder: (context, state) {
                if (state.stateEnum == StateEnum.loading) {
                  return const LoadingListTaskWidget();
                } else if (state.stateEnum == StateEnum.error) {
                  return ErrorListTaskWidget(
                    onPressed: () =>
                        _doneTasksBloc.add(GetCompletedTasksEvent()),
                  );
                } else if (state.tasks == null || state.tasks!.isEmpty) {
                  return const EmptyListTaskWidget();
                }

                return ListView.builder(
                  itemCount: state.tasks!.length,
                  itemBuilder: (context, index) {
                    return TaskItemDoneWidget(
                      task: state.tasks![index],
                      onDelete: () => _doneTasksBloc.add(
                        DeleteTasksById(
                          id: state.tasks![index].id!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
