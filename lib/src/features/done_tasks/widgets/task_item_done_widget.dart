import 'package:flutter/material.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/models/task_model.dart';

class TaskItemDoneWidget extends StatelessWidget {
  const TaskItemDoneWidget({
    required this.task,
    required this.onDelete,
    super.key,
  });
  final TaskModel task;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Transform.scale(
          scale: 1.33,
          child: Checkbox(
            value: task.isCompleted,
            onChanged: (_) => {},
            checkColor: UIAppColors.paleWhite,
            fillColor: WidgetStateProperty.all(
              UIAppColors.mutedAzure,
            ),
          ),
        ),
        title: Text(
          task.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: UIAppColors.slateBlue,
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
            color: UIAppColors.fireRed,
          ),
          onPressed: () => onDelete(),
        ),
      ),
    );
  }
}
