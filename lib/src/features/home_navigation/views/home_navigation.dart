import 'package:flutter/material.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/widgets/app_bar_widget.dart';
import 'package:taski/src/features/create_task/view/create_task_view.dart';
import 'package:taski/src/features/done_tasks/views/done_tasks_page.dart';
import 'package:taski/src/features/home_navigation/widgets/app_bottom_navigation_widget.dart';
import 'package:taski/src/features/list_task/view/list_task_page.dart';
import 'package:taski/src/features/search_task/views/search_task_page.dart';

class HomeNavigationPage extends StatefulWidget {
  const HomeNavigationPage({super.key});

  @override
  State<HomeNavigationPage> createState() => _HomeNavigationPageState();
}

class _HomeNavigationPageState extends State<HomeNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ListTaskPage(),
    const SizedBox(),
    const SearchTaskPage(),
    const DoneTasksPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIAppColors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: AppBottomNavigationWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    if (index == 1) {
      CreateTaskView.showBottomSheet(context);
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }
}
