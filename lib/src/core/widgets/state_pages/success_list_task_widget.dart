import 'package:flutter/material.dart';
import 'package:taski/src/core/models/task_model.dart';
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

class _SuccessListTaskWidgetState extends State<SuccessListTaskWidget> {
  @override
  void initState() {
    super.initState();
  }

  void _toggleTask(int index) {
    final updatedTask = widget.tasks[index].toggleValue(
      isCompleted: !widget.tasks[index].isCompleted,
    );

    // TODO: Chamar o bloc de atualizar o objeto localmente

    setState(() {
      widget.tasks[index] = updatedTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.tasks.length,
      itemBuilder: (context, index) {
        return TaskItemWidget(
          task: widget.tasks[index],
          onToggle: () => _toggleTask(index),
        );
      },
    );
  }
}
