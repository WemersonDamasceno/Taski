import 'package:flutter/material.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/models/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  const TaskItemWidget({required this.task, super.key, this.onToggle});
  final TaskModel task;
  final VoidCallback? onToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Transform.scale(
          scale: 1.33,
          child: Checkbox(
            value: task.isCompleted,
            onChanged: (_) => onToggle?.call(),
          ),
        ),
        title: Text(
          task.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: UIAppColors.slatePurple,
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
            color: UIAppColors.slateBlue,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
