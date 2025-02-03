import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/list_task/presentation/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggle;

  const TaskItemWidget({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
      color: AppColors.backgroundCard,
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        titleAlignment: ListTileTitleAlignment.top,
        leading: Checkbox(
          visualDensity: VisualDensity.compact,
          side: const BorderSide(color: AppColors.checkboxBorder),
          value: task.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          task.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.secondaryColor,
          ),
        ),
        subtitle: task.description.isNotEmpty
            ? Text(
                task.description,
                style: const TextStyle(color: AppColors.descriptionColor),
              )
            : null,
        trailing: IconButton(
          icon: const Icon(
            Icons.more_horiz,
            color: AppColors.descriptionColor,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
