import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taski/src/list_task/presentation/view/list_task_view.dart';
import 'package:taski/src/list_task/presentation/view_model/task_view_model.dart';

void main() {
  runApp(const TaskiApp());
}

class TaskiApp extends StatelessWidget {
  const TaskiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskViewModel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TaskListView(),
      ),
    );
  }
}
