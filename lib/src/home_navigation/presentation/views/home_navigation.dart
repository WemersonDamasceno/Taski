import 'package:flutter/material.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/widgets/app_bar_widget.dart';
import 'package:taski/src/create_task/presentation/view/create_task_view.dart';
import 'package:taski/src/done_tasks/presentation/views/done_tasks_page.dart';
import 'package:taski/src/home_navigation/presentation/widgets/app_bottom_navigation_widget.dart';
import 'package:taski/src/list_task/presentation/view/list_task_page.dart';
import 'package:taski/src/search_task/presentation/views/search_task_page.dart';

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
      backgroundColor: AppColors.white,
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
