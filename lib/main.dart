import 'package:flutter/material.dart';
import 'package:taski/src/core/theme/theme_app.dart';
import 'package:taski/src/injection_container.dart';
import 'package:taski/src/list_task/presentation/view/list_task_page.dart';

void main() async {
  await initDependency();
  runApp(const TaskiApp());
}

class TaskiApp extends StatelessWidget {
  const TaskiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const ListTaskPage(),
    );
  }
}
