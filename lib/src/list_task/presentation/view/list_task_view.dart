import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/core/constants/app_colors.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/widgets/app_bar_widget.dart';
import 'package:taski/src/list_task/presentation/bloc/list_task_bloc.dart';
import 'package:taski/src/list_task/presentation/bloc/list_task_event.dart';
import 'package:taski/src/list_task/presentation/bloc/list_task_state.dart';
import 'package:taski/src/list_task/presentation/widgets/empty_list_task_widget.dart';
import 'package:taski/src/list_task/presentation/widgets/error_list_task_widget.dart';
import 'package:taski/src/list_task/presentation/widgets/loading_list_task_widget.dart';
import 'package:taski/src/list_task/presentation/widgets/success_list_task_widget.dart';

class ListTaskView extends StatefulWidget {
  const ListTaskView({super.key});

  @override
  State<ListTaskView> createState() => _ListTaskViewState();
}

class _ListTaskViewState extends State<ListTaskView> {
  late ListTaskBloc _taskCubit;

  @override
  void initState() {
    super.initState();

    _taskCubit = GetIt.I.get<ListTaskBloc>();
    _taskCubit.add(GetUncompletedTasksEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<ListTaskBloc, StateListTask>(
          bloc: _taskCubit,
          builder: (context, state) {
            switch (state.stateEnum) {
              case StateEnum.success:
                return SuccessListTaskWidget(tasks: state.tasks!);
              case StateEnum.error:
                return ErrorListTaskWidget(
                  onPressed: () => _taskCubit.add(GetUncompletedTasksEvent()),
                );
              case StateEnum.empty:
                return const EmptyListTaskWidget();
              case StateEnum.loading:
              case StateEnum.initial:
                return const LoadingListTaskWidget();
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        enableFeedback: true,
        selectedItemColor: AppColors.blue,
        unselectedItemColor: AppColors.mutedAzure,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: AppColors.white,
            icon: Icon(Icons.ballot_outlined),
            label: "Todo",
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.white,
            icon: Icon(Icons.add_box_outlined),
            label: "Create",
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.white,
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            backgroundColor: AppColors.white,
            icon: Icon(Icons.check_box_outlined),
            label: "Done",
          ),
        ],
      ),
    );
  }
}
