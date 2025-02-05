import 'package:flutter/material.dart';
import 'package:taski/src/core/theme/theme_app.dart';
import 'package:taski/src/home_navigation/presentation/views/home_navigation.dart';
import 'package:taski/src/injection_container.dart';

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
      home: const HomeNavigationPage(),
    );
  }
}
