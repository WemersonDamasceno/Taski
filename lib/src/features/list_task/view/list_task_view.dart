import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:taski/src/core/enums/state_enum.dart';
import 'package:taski/src/core/widgets/header_page.dart';
import 'package:taski/src/core/widgets/header_page_loading.dart';
import 'package:taski/src/core/widgets/state_pages/empty_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/error_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/loading_list_task_widget.dart';
import 'package:taski/src/core/widgets/state_pages/success_list_task_widget.dart';
import 'package:taski/src/features/list_task/bloc/list_task_bloc.dart';
import 'package:taski/src/features/list_task/bloc/list_task_event.dart';
import 'package:taski/src/features/list_task/bloc/list_task_state.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0),
      child: BlocBuilder<ListTaskBloc, StateListTask>(
        bloc: _taskCubit,
        builder: (context, state) {
          switch (state.stateEnum) {
            case StateEnum.empty:
            case StateEnum.notFound:
              return const EmptyListTaskWidget();
            case StateEnum.error:
              return ErrorListTaskWidget(
                onPressed: () => _taskCubit.add(GetUncompletedTasksEvent()),
              );
            case StateEnum.success:
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderPage(tasks: state.tasks!),
                  Expanded(child: SuccessListTaskWidget(tasks: state.tasks!)),
                ],
              );
            case StateEnum.loading:
            case StateEnum.initial:
              return const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderPageLoading(),
                  Expanded(
                    child: LoadingListTaskWidget(),
                  ),
                ],
              );
          }
        },
      ),
    );
  }
}
