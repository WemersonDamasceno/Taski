import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/extensions/theme_extension.dart';
import 'package:taski/src/core/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel task;
  final VoidCallback onToggle;

  const TaskItemWidget({super.key, required this.task, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Transform.scale(
          scale: 1.33,
          child: Checkbox(
            value: task.isCompleted,
            onChanged: (_) => onToggle(),
          ),
        ),
        title: Text(
          task.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.slatePurple,
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
            Icons.more_horiz,
            color: AppColors.slateBlue,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
