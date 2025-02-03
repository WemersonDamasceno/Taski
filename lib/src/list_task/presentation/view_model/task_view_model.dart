import 'package:flutter/material.dart';
import 'package:taski/src/list_task/presentation/models/task_model.dart';

class TaskViewModel extends ChangeNotifier {
  final List<TaskModel> _tasks = [
    TaskModel(
      title: "Design sign up flow",
      description:
          "By the time a prospect arrives at your signup page, in most cases, they've already By the time a prospect arrives at your signup pagem in most cases.",
    ),
    TaskModel(title: "Design use case page", description: ""),
    TaskModel(title: "Test Wireframe", description: ""),
    TaskModel(title: "Create new task UI flow", description: ""),
    TaskModel(title: "Collect project assets", description: ""),
    TaskModel(title: "Collect Skills list", description: ""),
  ];

  List<TaskModel> get tasks => _tasks;

  void toggleTaskStatus(int index) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
  }
}
