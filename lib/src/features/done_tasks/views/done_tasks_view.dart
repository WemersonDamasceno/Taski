import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';
import 'package:taski/src/core/mixins/task_listener_mixin.dart';
import 'package:taski/src/core/mixins/task_notifier_mixin.dart';
import 'package:taski/src/core/models/task_event.dart';
import 'package:taski/src/core/widgets/button/view/app_buttom_widget.dart';
import 'package:taski/src/core/widgets/snackbar/snackbar_mixin.dart';
import 'package:taski/src/core/widgets/state_pages/empty_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/error_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/loading_list_task_widget.dart';
import 'package:taski/src/features/done_tasks/bloc/enable_buton/enable_button_cubit.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_bloc.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_event.dart';
import 'package:taski/src/features/done_tasks/bloc/list_done_task/list_done_task_state.dart';
import 'package:taski/src/features/done_tasks/widgets/header_done_tasks_widget.dart';
import 'package:taski/src/features/done_tasks/widgets/task_item_done_widget.dart';

class DoneTasksView extends StatefulWidget {
  const DoneTasksView({super.key});

  @override
  State<DoneTasksView> createState() => _DoneTasksViewState();
}

class _DoneTasksViewState extends State<DoneTasksView>
    with TaskListenerMixin, TaskNotifierMixin, SnackbarMixin {
  late ListDoneTaskBloc _doneTasksBloc;
  late EnableDeleteButtonCubit _enableButtonCubit;

  @override
  void initState() {
    super.initState();
    _doneTasksBloc = GetIt.I.get<ListDoneTaskBloc>();
    _enableButtonCubit = GetIt.I.get<EnableDeleteButtonCubit>();
    _doneTasksBloc.add(GetCompletedTasksEvent());
  }

  @override
  void onTaskModified(TaskEvent event) {
    _doneTasksBloc.add(GetCompletedTasksEvent());
    if (event.operation == TaskOperation.delete) {
      showSnackbar(
        context: context,
        message: AppStrings.successDeleteTask,
        backgroundColor: AppColors.greenPure,
        iconData: Icons.check_circle_outline_rounded,
        fontColor: AppColors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: Column(
        children: [
          HeaderCompletedTasks(
            enableDeleteButton: _enableButtonCubit,
            onPressed: () => _showDialog(
              context: context,
              title: AppStrings.deleteAllTasksTitle,
              description: AppStrings.deleteAllTasksDescription,
              onConfirm: () => _doneTasksBloc.add(DeleteAllTasksDone()),
            ),
          ),
          Expanded(
            child: BlocBuilder<ListDoneTaskBloc, ListDoneTaskState>(
              bloc: _doneTasksBloc,
              builder: (context, state) {
                _enableButtonCubit
                    .changeState(state.tasks?.isNotEmpty ?? false);
                if (state.stateEnum == StateEnum.deleted) {
                  notifyTaskModification(null, TaskOperation.delete);
                }
                if (state.stateEnum == StateEnum.loading) {
                  return const LoadingListTaskWidget();
                } else if (state.stateEnum == StateEnum.error) {
                  return ErrorListTaskWidget(
                    onPressed: () => _doneTasksBloc.add(
                      GetCompletedTasksEvent(),
                    ),
                  );
                } else if (state.tasks == null || state.tasks!.isEmpty) {
                  return const EmptyListTaskWidget(
                    showButton: false,
                  );
                }

                return ListView.builder(
                  itemCount: state.tasks!.length,
                  itemBuilder: (context, index) {
                    return TaskItemDoneWidget(
                      task: state.tasks![index],
                      onDelete: () => _showDialog(
                        context: context,
                        title: AppStrings.deleteTasks,
                        description: AppStrings.deleteTaskDescription,
                        onConfirm: () => _doneTasksBloc.add(
                          DeleteTasksById(
                            id: state.tasks![index].id!,
                          ),
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

  void _showDialog({
    required BuildContext context,
    required String title,
    required String description,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16),
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: context.textTheme.titleLarge?.copyWith(
            color: AppColors.slatePurple,
          ),
        ),
        content: Text(
          description,
          textAlign: TextAlign.start,
          style: context.textTheme.bodyMedium?.copyWith(
            color: AppColors.slateBlue,
          ),
        ),
        actions: [
          AppButtonWidget.textButton(
            label: 'Cancelar',
            colorLabel: AppColors.slatePurple,
            onPressed: () => Navigator.pop(context),
          ),
          AppButtonWidget.filled(
            label: 'Deletar',
            onPressed: () {
              Navigator.pop(context);
              onConfirm();
            },
          ),
        ],
      ),
    );
  }
}
