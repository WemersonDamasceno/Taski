import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nova_design_system/nova_design_system.dart';
import 'package:taski/src/core/widgets/app_bar_widget.dart';
import 'package:taski/src/features/create_task/view/create_task_view.dart';
import 'package:taski/src/features/done_tasks/views/done_tasks_page.dart';
import 'package:taski/src/features/home/bloc/internet_listener_bloc.dart';
import 'package:taski/src/features/home/bloc/internet_listener_event.dart';
import 'package:taski/src/features/home/bloc/internet_listener_state.dart';
import 'package:taski/src/features/home/widgets/app_bottom_navigation_widget.dart';
import 'package:taski/src/features/list_task/view/list_task_page.dart';
import 'package:taski/src/features/search_task/views/search_task_page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with UISnackbarMixin {
  late InternetListenerBloc _internetListenerBloc;
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const ListTaskPage(),
    const SizedBox(),
    const SearchTaskPage(),
    const DoneTasksPage(),
  ];

  @override
  void initState() {
    super.initState();

    _internetListenerBloc = GetIt.I.get<InternetListenerBloc>();
    _internetListenerBloc.add(VerifyInternetConnection());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetListenerBloc, InternetState>(
      bloc: _internetListenerBloc,
      listener: (context, state) {
        if (state.statusConnection == ConnectionStatus.connected) {
          //Chamar usecase para sincronizar os dados...
        }
      },
      child: Scaffold(
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
