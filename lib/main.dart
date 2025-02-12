import 'package:flutter/material.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/features/home_navigation/views/home_navigation.dart';
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
      theme: UIAppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeNavigationPage(),
    );
  }
}
