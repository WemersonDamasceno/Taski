import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/constants/app_strings.dart';
import 'package:taski/src/core/models/task_model.dart';
import 'package:taski/src/list_task/presentation/widgets/task_item_widget.dart';

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
  late List<TaskModel> _tasks;

  @override
  void initState() {
    super.initState();
    _tasks = List.from(widget
        .tasks); // Clona a lista original para evitar modificar diretamente
  }

  void _toggleTask(int index) {
    final updatedTask =
        _tasks[index].toggleValue(isCompleted: !_tasks[index].isCompleted);

    // TODO: Chamar o bloc de atualizar o objeto localmente

    setState(() {
      _tasks[index] = updatedTask;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              TextSpan(
                text: AppStrings.welcomeTitle,
                style: TextStyle(
                  color: AppColors.slatePurple,
                ),
              ),
              TextSpan(
                text: "John.",
                style: TextStyle(
                  color: AppColors.blue,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.welcomeDescription(_tasks.length.toString()),
          style: const TextStyle(
            color: AppColors.slateBlue,
            fontSize: 16,
          ),
        ),
        const SizedBox(height: 24),
        Expanded(
          child: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) {
              return TaskItemWidget(
                task: _tasks[index],
                onToggle: () => _toggleTask(index),
              );
            },
          ),
        ),
      ],
    );
  }
}
