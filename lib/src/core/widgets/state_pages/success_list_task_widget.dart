import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/core/bloc/update_task_bloc.dart';
import 'package:taski/src/core/bloc/update_task_event.dart';
import 'package:taski/src/core/bloc/update_task_state.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/mixins/task_notifier_mixin.dart';
import 'package:taski/src/core/models/task_event.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/core/widgets/snackbar/snackbar_mixin.dart';
import 'package:taski/src/core/widgets/task_item_widget.dart';

class SuccessListTaskWidget extends StatefulWidget {
  final List<TaskModel> tasks;

  const SuccessListTaskWidget({
    super.key,
    required this.tasks,
  });

  @override
  State<SuccessListTaskWidget> createState() => _SuccessListTaskWidgetState();
}

class _SuccessListTaskWidgetState extends State<SuccessListTaskWidget>
    with TaskNotifierMixin, SnackbarMixin {
  late UpdateTaskBloc _updateTaskBloc;

  @override
  void initState() {
    super.initState();

    _updateTaskBloc = GetIt.I.get<UpdateTaskBloc>();
  }

  void _toggleTask(int index) {
    final updatedTask = widget.tasks[index].copyWith(
      isCompleted: !widget.tasks[index].isCompleted,
    );

    setState(() {
      widget.tasks[index] = updatedTask;

      Future.delayed(const Duration(seconds: 1)).whenComplete(() {
        _updateTaskBloc.add(
          UpdateTask(
            taskModel: widget.tasks[index],
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateTaskBloc, UpdateTaskState>(
      bloc: _updateTaskBloc,
      listener: (context, state) {
        if (state.stateEnum == StateEnum.success) {
          showSnackbar(
            context: context,
            fontColor: AppColors.white,
            backgroundColor: AppColors.greenPure,
            iconData: Icons.check_circle_outline_rounded,
            message: AppStrings.taskCompleted(
              _formatteTitle(state.task!.title),
            ),
          );
          notifyTaskModification(state.task, TaskOperation.createOrUpdate);
        }
      },
      child: ListView.builder(
        itemCount: widget.tasks.length,
        itemBuilder: (context, index) {
          return TaskItemWidget(
            task: widget.tasks[index],
            onToggle: () => _toggleTask(index),
          );
        },
      ),
    );
  }

  String _formatteTitle(String title) {
    if (title.length > 10) {
      return '${title.substring(0, 10)}...';
    }
    return title;
  }
}
