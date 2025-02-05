import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';
import 'package:taski/src/core/models/task_model.dart';

class TaskItemDoneWidget extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onDelete;

  const TaskItemDoneWidget({
    super.key,
    required this.task,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Transform.scale(
          scale: 1.33,
          child: Checkbox(
            value: task.isCompleted,
            onChanged: (_) => {},
            checkColor: AppColors.paleWhite,
            fillColor: WidgetStateProperty.all(
              AppColors.mutedAzure,
            ),
          ),
        ),
        title: Text(
          task.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.slateBlue,
          ),
        ),
        subtitle: task.description.isNotEmpty
            ? Text(
                task.description,
                style: context.textTheme.bodySmall,
              )
            : null,
        trailing: IconButton(
          icon: const Icon(
            Icons.delete_rounded,
            color: AppColors.fireRed,
          ),
          onPressed: () => onDelete(),
        ),
      ),
    );
  }
}
